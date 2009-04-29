class Sale < ActiveRecord::Base

  belongs_to :store, :class_name => 'List'
  has_many :sale_items, :dependent => :destroy

  default_scope :order => 'created_at DESC'

  alias :orderid :id

  def can_be_captured?
    paid and !tid.blank?
  end

  def extract!(cart)
    self.store = cart.store
    cart.cart_items.each do |cart_item|
      sale_items.build.extract(cart_item)
    end
    use_list_credit
    verify_if_need_payment!
    save
  end
  
  def verify_if_need_payment!
    unless need_payment?
      pay!(false)
    end
  end
  
  def use_list_credit
    return if store.credit == 0
    
    if store.credit < total_price
      self.credit = store.credit
    else
      self.credit = total_price
    end
  end
  
  def remove_credit_from_store
    return true if credit == 0
    return false if store.credit < credit
    store.update_attributes :credit => store.credit - credit
  end

  def pay!(visanet = true)
    return false if store.delivery
    
    self.paid = true
    self.tid = temp_tid if visanet
    self.gift = true unless visanet
    
    status = true
    
    Sale.transaction do
      status = remove_credit_from_store unless visanet
    
      if status
        status = save
      else
        status = false
      end
    end
    
    return status
  end

  def capture!
    return false if store.delivery
  
    status = true

    Sale.transaction do
      credit_ok = remove_credit_from_store
      if credit_ok
        status = update_attributes :captured => true, :gift => true
      end
    end
    
    return status
  end

  def archive!
    update_attributes! :archived => !archived
  end

  def total_price
    total = 0
    sale_items.each { |item| total += item.total_price }
    total
  end
  
  def total_price_to_pay
    if total_price >= credit
      total_price - credit
    else
      0
    end
  end
  
  def has_credit?
    credit > 0
  end
  
  def has_payment?
    total_price_to_pay > 0
  end
  
  def need_payment?
    total_price_to_pay > 0
  end

  alias :price :total_price_to_pay

  def has_gift_for_delivery?
    return false unless gift
    sale_items.each do |sale_item|
      return true if sale_item.quantity_left > 0
    end
    return false
  end

end
