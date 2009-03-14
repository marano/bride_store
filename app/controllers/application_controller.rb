# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  helper :all # include all helpers, all the time
  helper_method :current_list, :site
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  protected

  def save_success
    flash[:notice] = 'Dados salvos com sucesso!'
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
    if @site.nil?
      @site = Site.first
      if @site.nil?
        @site = Site.new
      end
    end
    @site
  end
  
  def email_config
    config = EmailConfig.first
    if config.nil?
      config = EmailConfig.new
    end
    config
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

