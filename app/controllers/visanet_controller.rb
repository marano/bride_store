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
    @price = params[:price]
    
    if @price != VisanetSale.new(@sale).price
      @message = 'O valor pago é diferente do valor da venda!'
      flash[:error] = @message
    else
      if @lr == '00' or @lr == '01'
        if @sale.pay!(true)
          @message = 'Pagamento efetuado com sucesso!'
          flash[:notice] = @message
        else
          @message = 'A venda não pôde ser paga! Por favor entre em contato com a loja.'
          flash[:error] = @message
        end        
      else
        @message = 'Não foi possível efetuar o pagamento!'
        flash[:error] = @message
      end
    end
    render :layout => false
  end

  def send_to_capture
    @sale = Sale.find(params[:sale_id])
    visa_params = VisanetSale.new(@sale).send_to_capture_params
    render_redirect_to 'https://comercio.locaweb.com.br/comercio.comp', visa_params
  end

  def complete_capture
    @sale = Sale.scoped_by_tid(params[:tid]).first
    @tid = params[:tid]
    @lr = params[:lr]
    @ars = params[:ars]
    if @lr == '0' or @lr == '3'
      @sale.capture!
      flash[:notice] = 'Pagamento capturado com sucesso!'
    else
      flash[:error] = 'Não foi possível capturar o pagamento!'
    end
    redirect_to @sale
  end

  def parcial_capture

  end

  def status

  end

  def cancel

  end

end

