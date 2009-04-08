require 'net/http'
require 'uri'

class VisanetSale

  def initialize(sale)
    @sale = sale
  end

  def send_to_payment
    response = Net::HTTP.post_form(URI.parse('https://comercio.locaweb.com.br/comercio.comp'),
    send_to_payment_params)

    response['location']
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

  def price
    helpers.number_with_precision(@sale.price, :precision => 2).gsub(',', '').gsub('.', '')
  end

  def damount
    "R$ #{helpers.number_with_precision @sale.price, :precision => 2}"
  end

  def tid    
    return @sale.tid unless @sale.tid.blank?
      
    id = LOJA_VISA[4, 9]
    data = Date.today
    hora = Time.now
    data_hora = DateTime.now
    id << data_hora.year.to_s[3, 4]
    id << concat_before_until_reach(data.yday.to_s, '0', 3)
    id << concat_before_until_reach(hora.hour.to_s, '0', 2)
    id << concat_before_until_reach(hora.min.to_s, '0', 2)
    id << concat_before_until_reach(hora.sec.to_s, '0', 2)
    id << '10'
    id << '01'
    @sale.update_attributes! :tid => id
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

end
