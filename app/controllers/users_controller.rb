class UsersController < ApplicationController

  layout 'adm'

  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :adm_required, :except => ['new', 'create', 'update', 'activate', 'account', 'account_list', 'forgot_password', 'send_password' ]
  before_filter :login_required, :only => ['update']

  def send_password
    @user = User.scoped_by_email(params[:email]).first
    if @user
      if @user.generate_random_password!
        UserMailer.deliver_password(@user)
        flash[:notice] = "Obrigado! Estamos enviando uma nova senha!"      
        redirect_to login_path
      else
        flash[:error] = "Não foi possível gerar uma nova senha para #{params[:email]}!"
        redirect_to forgot_password_path
      end
    else
      flash[:error] = "Não foi possível localizar o usuário com o endereço #{params[:email]}!"
      redirect_to forgot_password_path
    end
  end
  
  def forgot_password
    render :layout => 'application'
  end

  def account
    if logged_in?
      redirect_to new_list_path
    else
      redirect_to new_user_path
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
  end

  # render new.rhtml
  def new
    @user = User.new
    @user.newsletter = true
    render :layout  => 'application'
  end

  def new_admin
    @user = User.new
  end

  def update_admin
    update
  end

  def index
    @users = User.all :conditions => "state NOT LIKE 'deleted' AND state NOT LIKE 'passive'"
  end

  def update
    @user = User.find(params[:id])

    params[:user].delete :password if params[:user][:password].blank?
    params[:user].delete :password_confirmation if params[:user][:password_confirmation].blank?

    if @user.update_attributes(params[:user])
      save_success
      if @user.admin?
        redirect_to users_path
      else
        redirect_to account_path        
      end
    else
      save_error
      if(current_user.admin?)
        render :action => 'edit'
      else
        render :action => 'new', :controller => 'list', :layout => 'application'
      end
    end
  end

  def create        
    logout_keeping_session!
    params[:user][:email].strip!
    
    user_by_mail = User.scoped_by_email(params[:user][:email]).first
    if user_by_mail and user_by_mail.can_be_created?
      @user = user_by_mail
      @user.attributes = params[:user]
    else
      @user = User.new(params[:user])
    end
    
    unless params[:aceitouTermos]
      flash[:error]  = "É necessário aceitar os termos de uso para criar uma conta!"
      render :action => 'new', :layout => 'application'
      return
    end
    
    if params[:newsletter]
      @user.newsletter = true
    end
    
    @user.admin = false
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    
    if success && @user.errors.empty?
      flash[:notice] = "Obrigado por cadastrar-se! Estamos enviando para você o email de ativação."
      redirect_to root_path
    else
      flash[:error]  = "Não foi possível criar esta conta, desculpe.  Por favor tente de novo, ou contacte o administrador do sistema."
      render :action => 'new', :layout => 'application'
    end
  end

  def create_admin
    params[:user][:email].strip!
    user_by_mail = User.scoped_by_email(params[:user][:email]).first
    if user_by_mail and user_by_mail.can_be_created?
      @user = user_by_mail
      @user.attributes = params[:user]
    else
      @user = User.new(params[:user])
    end
    
    if params[:newsletter]
      @user.newsletter = true
    end
    
    @user.admin = !params[:user].delete(:admin).nil?
    
    @user.activate!
    
    if @user.save
      redirect_to users_path
      flash[:notice] = "Usuário criado com sucesso!"
    else
      flash[:error]  = "Erro ao criar usuário"
      render :action => 'new_admin'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      self.current_user = user
      handle_remember_cookie! true
      redirect_to account_list_path
      flash[:notice] = "Usuário ativado!"      
    when params[:activation_code].blank?
      flash[:error] = "Por favor informe o código de ativação"
      redirect_back_or_default('/')
    else
      flash[:error]  = "Não foi possível achar o usuário com o código de ativação!"
      redirect_back_or_default('/')
    end
  end

  def suspend
    @user.suspend!
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend!
    redirect_to users_path
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end

  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

  protected
  def find_user
    @user = User.find(params[:id])
  end
end

