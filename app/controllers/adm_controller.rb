class AdmController < ApplicationController

  layout 'adm'
  
  before_filter :login_required
  
  def home
  end
end
