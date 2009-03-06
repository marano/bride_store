class Money
  include ActionView::Helpers::NumberHelper

  def to_s
    nummber_to_currency @price
  end
end
