class VisanetController < ApplicationController

  def send_to_payment
    @sale = Sale.find(params[:sale_id])
    visa_params = VisanetSale.new(@sale).send_to_payment_params
    #visa_params['visa_antipopup'] = '1'
    redirect_from_post 'https://comercio.locaweb.com.br/comercio.comp', visa_params
  end

  def confirm
    @sale = Sale.find(params[:orderid])    
    redirect_to resend_visanet_path(@sale)
  end

  def resend
    @sale = Sale.find(params[:sale_id])
    visa_params = VisanetSale.new(@sale).confirm_payment_params
    visa_params['URLRetornoVisa'] = complete_visanet_url
    redirect_from_post 'https://comercio.locaweb.com.br/comercio.comp', visa_params
  end

  def complete
    @sale = Sale.find(params[:orderid])
    @lr = params[:lr]
    if @lr == '00' or @lr == '01'
      @sale.pay
      flash[:notice] = 'Pagamento efetuado com sucesso!'
    else
      flash[:error] = 'Não foi possível concluir o processo de pagamento!'
    end
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