require 'net/http'
require 'uri'

class VisanetSale

  def initialize(sale)
    @sale = sale
  end

  def send_to_payment_params
    {
      'identificacao'=> COMERCIO_ELETRONICO_LOCAWEB,
      'meiopag'=> 'VISANET',
      'ambiente'=> AMBIENTE_PAGAMENTO,
      'modulo'=> 'VISAVBV',
      'operacao'=> 'Pagamento',
      'order'=> @sale.to_s,
      'tid'=> tid,
      'orderid'=> @sale.orderid,
      'price'=> price,
      'damount'=> damount
    }
  end

  def resend_to_payment_params
    {
      'identificacao'=> COMERCIO_ELETRONICO_LOCAWEB,
      'ambiente'=> AMBIENTE_PAGAMENTO,
      'modulo'=> 'VISAVBV',
      'operacao'=> 'Retorno',
      'tid'=> tid
    }
  end
  
  def send_to_capture_params
    {
      'identificacao'=> COMERCIO_ELETRONICO_LOCAWEB,
      'ambiente'=> AMBIENTE_PAGAMENTO,
      'modulo'=> 'VISAVBV',
      'operacao'=> 'Captura',
      'tid'=> tid
    }
  end

  def price
    helpers.number_with_precision(@sale.price, :precision => 2).gsub(',', '').gsub('.', '')
  end

  def damount
    "R$ #{helpers.number_with_precision @sale.price, :precision => 2}"
  end

  def tid
    if @sale.paid
      return @sale.tid
    else
      return @sale.temp_tid unless @sale.temp_tid.blank?
    end

    id = LOJA_VISA[4..8]
    data = Date.today
    hora = Time.now
    data_hora = DateTime.now
    id << data_hora.year.to_s[3]
    id << concat_before_until_reach(data.yday.to_s, '0', 3)
    id << concat_before_until_reach(hora.hour.to_s, '0', 2)
    id << concat_before_until_reach(hora.min.to_s, '0', 2)
    id << concat_before_until_reach(hora.sec.to_s, '0', 2)
    id << hora.usec.to_s[0]
    id << '10'
    id << '01'
    @sale.update_attributes! :temp_tid => id
    id
  end

  def concat_before_until_reach(text, concat, limit)
    while text.size < limit do
      text = concat + text
    end
    text
  end

  def helpers
    ActionController::Base.helpers
  end

  #  def send_to_payment
  #    response = Net::HTTP.post_form(URI.parse('https://comercio.locaweb.com.br/comercio.comp'),
  #    send_to_payment_params)

  #    response['location']
  #  end

end
