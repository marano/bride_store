# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include SortableTable::App::Controllers::ApplicationController

  helper :all # include all helpers, all the time
  helper_method :site, :user_session, :current_list, :current_store, :current_cart
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  protected

  def save_success
    flash[:notice] = 'Dados salvos com sucesso!'
  end

  def save_error
    flash[:error] = 'Os dados não foram salvos!'
  end

  def user_session
    @user_session ||= UserSession.new(session)
  end

  def set_current_store(store)
    user_session.current_store = store
  end

  def current_store
    user_session.current_store
  end

  def set_current_list(list)
    user_session.current_list = list
  end

  def current_list?(list)
    user_session.current_list = list
  end

  def current_list
    user_session.current_list
  end

  def current_cart
    user_session.current_cart
  end

  def current_cart?
   !!current_cart
  end

  def clear_cart
    user_session.clear_cart
  end
  
  def site
    @site ||= Site.first || Site.new
  end

  def email_config
    EmailConfig.first || EmailConfig.new
  end
  
  def redirect_page(to, params)
    @parameters = params
    @parameters[:to] = to
    render 'redirect/to', :layout => 'site'
  end
end

