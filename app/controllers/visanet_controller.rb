class VisanetController < ApplicationController

  def send_to_payment
    @sale = Sale.find(params[:sale_id])
    redirect_page 'https://comercio.locaweb.com.br/comercio.comp', VisanetSale.new(@sale).send_to_payment_params
  end
  
  def confirm
  
  end
  
  def resend
  
  end
  
  def capture
  
  end
  
  def parcial_capture
  
  end
  
  def status
    
  end
  
  def cancel
    
  end
  
end
