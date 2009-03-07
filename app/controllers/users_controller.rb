class UsersController < ApplicationController

  layout 'adm'
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :login_required, :except => ['new', 'create', 'activate']

  # render new.rhtml
  def new
    @user = User.new
    render :layout  => 'site'
  end
  
  def index
    @users = User.all :conditions => "state NOT LIKE 'deleted'"
  end
  
  def update
    @user = User.find(params[:id])

    params[:user] -= :password if params[:user][:password].blank?
    params[:user] -= :password_confirmation if params[:user][:password_confirmation].blank?

    if @user.update_attributes(params[:user])
      save_success
      redirect_to users_path
    else
      flash[:error] = "Couldn't update Usee!"
      render :action => 'edit'
    end
  end
 
#  def create_admin
#    @user = User.new(params[:user])
#    @user.admin = true
#    @user.register!
#    @user.do_activate
#    @user.activate!
#    @user.save
#  end

  def create_admin
    create
  end
 
  def create
    #logout_keeping_session!
    @user = User.new(params[:user])
    @user.admin = false
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."      
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end    
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
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
