# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include SortableTable::App::Controllers::ApplicationController

  helper :all # include all helpers, all the time
  helper_method :current_list, :current_store, :current_cart, :site
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
  
  def set_current_store(store)
    if store.nil?
      session[:current_store] = nil
    else
      session[:current_store] = store.id
    end
  end
  
  def current_store
    if session[:current_store].nil?
      nil
    else
      if(@current_store.nil?)
        @current_store = List.find(session[:current_store])
      end
      @current_store
    end
  end

  def set_current_list(list)
    if list.nil?
      session[:current_list] = nil
    else
      session[:current_list] = list.id
    end
  end

  def current_list?(list)
    session[:current_list] == list.id 
  end

  def current_list
    if session[:current_list].nil?
      nil
    else
      if(@current_list.nil?)
        @current_list = List.find(session[:current_list])
      end
      @current_list
    end
  end

  def site
    @site ||= Site.first || Site.new
  end
  
  def email_config
    EmailConfig.first || EmailConfig.new
  end

  def current_cart
    @current_cart ||= session[:cart] ||= Cart.new
  end

#  def authorized?(action = action_name, resource = nil)
#    #logged_in?
#    if @require_admin =~ action_name.to_sym
#      logged_in? and current_user.admin?
#    else
#      logged_in?
#    end    
#  end
#  
#  def admin_required(actions)
#    unless actions.respond_to? 'each'
#      actions = [actions]
#    end
#    @require_admin = actions
#  end

end

