class ListItem < ActiveRecord::Base
  
  belongs_to :list
  belongs_to :product
  has_one :category, :through => :product
  
  def total_price
    product.price * quantity
  end
  
  def has_gift?
    quantity_bought > 0
  end
  
  def quantity_bought
    sum = 0
    list.gifts.each do |gift|
      sum = sum + gift.quantity if gift.product == product
    end
    sum
  end
end
