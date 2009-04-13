class AdmController < ApplicationController

  layout 'adm'  
  
  before_filter :adm_required
    
  def home
  end
  
end
