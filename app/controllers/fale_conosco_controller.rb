class FaleConoscoController < ApplicationController

  layout 'site'
  
  def new
  end
  
  def enviar
    user = User.find_by_email params[:email]
    if user.nil? 
      user = User.new(:name => params[:name], :email => params[:email], :phone => params[:phone])      
    end
    user.newsletter = params[:newsletter]
    user.save
    FaleConosco.deliver_message(email_config.email_adress, params[:name], params[:email], params[:phone], params[:message])
    redirect_to home_path
  end
end
