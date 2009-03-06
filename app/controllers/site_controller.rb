class SiteController < ApplicationController

  layout 'site'
  before_filter :login_required, :only => [:update]

  def home
  end
  
  def update
    fetch_site
    
    if @site.update_attributes(params[:site])
      save_success
      redirect_to adm_path
    else
      render :controller => 'site_adm', :action => params[:edit_what]
    end
  end
  
  def fetch_site
    @site = Site.first
    if @site.nil?
      @site = Site.new
      @site.save!
    end
  end
end
