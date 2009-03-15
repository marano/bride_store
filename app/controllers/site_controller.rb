class SiteController < ApplicationController

  layout 'site'
  before_filter :adm_required, :only => [:update]

  def home
  end
  
  def update    
    if site.update_attributes(params[:site])
      save_success
      redirect_to adm_path
    else
      render :controller => 'site_adm', :action => params[:edit_what]
    end
  end
end
