class Sale < ActiveRecord::Base

  belongs_to :store, :class_name => 'List'
  has_many :sale_items, :dependent => :destroy
  
  default_scope :order => 'created_at DESC'
  
  def extract(cart)
    cart.cart_items.each do |cart_item|
      cart_items.build.extract(cart_item)
    end
    cart.clear
  end
  
  def pay
    transaction do
      update_attribute :paid, true
      store.add_sale(self)
    end
  end
  
  def total_price
    total = 0
    sale_items.each { |item| total += item.total_price }
    total
  end
  
end
