class Sale < ActiveRecord::Base

  belongs_to :store, :class_name => 'List'
  has_many :sale_items, :dependent => :destroy
  
  default_scope :order => 'created_at DESC'
  
  alias :orderid :id
  
  def extract(cart)
    cart.cart_items.each do |cart_item|
      sale_items.build.extract(cart_item)
    end
  end
  
  def pay!
    update_attributes! :paid => true    
  end
  
  def archive!
    update_attributes! :archived => !archived
  end
  
  def total_price
    total = 0
    sale_items.each { |item| total += item.total_price }
    total
  end
  
  alias :price :total_price
  
  def has_gift_for_delivery?
    return false unless paid
    sale_items.each do |sale_item|
      return true if sale_item.quantity_left > 0
    end
    return false
  end
  
end
