class Sale < ActiveRecord::Base

  belongs_to :store, :class_name => 'List'
  has_many :sale_items, :dependent => :destroy

  default_scope :order => 'created_at DESC'

  alias :orderid :id

  def can_be_captured?
    paid and !tid.blank?
  end

  def extract(cart)
    cart.cart_items.each do |cart_item|
      sale_items.build.extract(cart_item)
    end
  end

  def pay!(visanet = true)
    self.paid = true    
    self.tid = temp_tid if visanet
    self.gift = true unless visanet
    save!
  end

  def capture!
    update_attributes! :captured => true, :gift => true
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
    return false unless gift
    sale_items.each do |sale_item|
      return true if sale_item.quantity_left > 0
    end
    return false
  end

end

