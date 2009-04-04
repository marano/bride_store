class ListItem < ActiveRecord::Base
  
  belongs_to :list
  belongs_to :product
  has_one :category, :through => :product
  
  def total_price
    product.price * quantity
  end
  
  def add_bought_quantity(sold_quantity)
    update_attribute :quantity_bought, (quantity_bought || 0) + sold_quantity
  end
end
