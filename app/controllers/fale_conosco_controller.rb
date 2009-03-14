class FaleConoscoController < ApplicationController

  layout 'site'
  
  def new
  end
  
  def enviar
    FaleConosco.deliver_message(email_config.email_adress, params[:name], params[:email], params[:phone], params[:message])
    redirect_to home_path
  end
end
