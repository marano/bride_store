class SaleItem < ActiveRecord::Base

  belongs_to :sale
  has_one :list, :through => :sale, :source => :store
  belongs_to :product

  def extract(cart_item)
    self.product = cart_item.product
    self.price = cart_item.product.price
    self.quantity = cart_item.quantity
  end

  def change(quantity)
    if quantity > quantity_left
      return false
    else
      SaleItem.transaction do
        update_attributes! :quantity_changed => quantity_changed + quantity
        list.add_credit(price * quantity)
      end
      return true
    end
  end

  def quantity_left
    quantity - quantity_changed
  end

  def total_price
    price * quantity
  end

end

