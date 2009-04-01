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
    session[:current_store] = store ? store.id : nil
  end
  
  def current_store
    @current_store ||= List.find(session[:current_store]) unless session[:current_store].nil?
  end

  def set_current_list(list)
    session[:current_list] = list ? list.id : nil
  end

  def current_list?(list)
    session[:current_list] == list.id 
  end

  def current_list
    @current_list ||= List.find(session[:current_list]) unless session[:current_list].nil?
  end

  def current_cart?
    session[:cart]
  end
  
  def clear_cart
    @current_cart = nil if current_cart?
  end

  def current_cart
    @current_cart ||= session[:cart] ||= Cart.new(current_store)
  end

  def site
    @site ||= Site.first || Site.new
  end
  
  def email_config
    EmailConfig.first || EmailConfig.new
  end
  
end

