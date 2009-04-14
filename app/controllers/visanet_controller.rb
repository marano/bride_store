class VisanetController < ApplicationController

  def verify_authenticity_token
    true
  end

  def send_to_payment
    @sale = Sale.find(params[:sale_id])
    visa_params = VisanetSale.new(@sale).send_to_payment_params
    #visa_params['visa_antipopup'] = '1'
    render_redirect_to 'https://comercio.locaweb.com.br/comercio.comp', visa_params
  end

  def confirm
    @sale = Sale.find(params[:orderid])
    redirect_to resend_visanet_path(@sale)
  end

  def resend
    @sale = Sale.find(params[:sale_id])
    visa_params = VisanetSale.new(@sale).resend_to_payment_params
    visa_params['URLRetornoVisa'] = complete_visanet_url
    render_redirect_to 'https://comercio.locaweb.com.br/comercio.comp', visa_params
  end

  def complete
    @sale = Sale.find(params[:orderid])
    @tid = params[:tid]
    @lr = params[:lr]
    @ars = params[:ars]
    if @lr == '00' or @lr == '01'
      @sale.pay(true)
      flash[:notice] = 'Pagamento efetuado com sucesso!'
    else
      flash[:error] = 'Não foi possível efetuar o pagamento!'
    end
    render :layout => false
  end

  def send_to_capture
    @sale = Sale.find(params[:sale_id])
    visa_params = VisanetSale.new(@sale).send_to_capture_params
    render_redirect_to 'https://comercio.locaweb.com.br/comercio.comp', visa_params
  end
  
  def complete_capture
    @sale = Sale.scoped_by_tid(params[:tid])    
    @tid = params[:tid]
    @lr = params[:lr]
    @ars = params[:ars]
    if @lr == '0'
      @sale.capture!
      flash[:notice] = 'Pagamento capturado com sucesso!'
    else
      flash[:error] = 'Não foi possível capturar o pagamento!'
    end
  end

  def parcial_capture

  end

  def status

  end

  def cancel

  end

end
