class SiteAdmController < ApplicationController

  layout 'adm'
  
  before_filter :login_required
  
  def home
    @site = site
  end
  
  def we
    @site = site
  end
  
  def showroom
    @site = site
  end
  
  def site_data
    @site = site
  end
end
