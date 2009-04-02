class SaleItem < ActiveRecord::Base

  belongs_to :sale
  belongs_to :product
  
  def extract(cart_item)
    product = cart_item.product
    price = cart_item.product.price
    quantity = cart_item.quantity
  end
  
  def total_price
    price * quantity
  end
  
end
