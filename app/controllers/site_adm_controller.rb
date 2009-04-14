class SiteAdmController < ApplicationController

  layout 'adm'
  
  before_filter :adm_required, :fetch_site
  
  def footer
  end
  
  def logo
  end
  
  def home
  end
  
  def we
  end
  
  def showroom    
  end
  
  def site_data
  end
  
  private
  
  def fetch_site
    @site = site
  end
end
