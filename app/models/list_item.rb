class ListItem < ActiveRecord::Base
  
  belongs_to :list
  belongs_to :product
  
  def total_price
    product.price * quantity
  end
  
  def category
    product.category
  end
end
