class SiteAdmController < ApplicationController

  layout 'adm'
  
  before_filter :login_required
  
  def home
    fetch_site
  end
  
  def we
    fetch_site
  end
  
  def showroom
    fetch_site
  end
  
  def site_data
    fetch_site
  end
  
  private
  
  def update
  end
  
  def fetch_site
    @site = Site.first
    if @site.nil?
      @site = Site.new
      @site.save!
    end
  end
end
