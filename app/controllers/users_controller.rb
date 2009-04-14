class UsersController < ApplicationController

  layout 'adm'

  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :adm_required, :except => ['new', 'create', 'update', 'activate', 'account', 'account_list' ]
  before_filter :login_required, :only => ['update']

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
    render :layout  => 'application'
  end

  def new_admin
    @user = User.new
  end

  def update_admin
    update
  end

  def index
    @users = User.all :conditions => "state NOT LIKE 'deleted'"
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
    user_by_mail = User.scoped_by_email(params[:user][:email])
    if user_by_mail and user_by_mail.state == 'passive'
      @user = user_by_mail
    else
      @user = User.new(params[:user])
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
    @user = User.new(params[:user])
    @user.admin = params[:admin]
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
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
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

