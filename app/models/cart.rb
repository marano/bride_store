class Cart

  def initialize(store)
    @store_id = store.id
  end
  
  def store
    List.find @store_id
  end

  def cart_items
    @cart_items ||= []
  end
  
  def add(product, quantity)
    cart_item = cart_item_by_product(product)
    if cart_item.nil?
      cart_items << CartItem.new(cart_items.size, product.id, quantity)
    else
      cart_item.quantity = quantity
    end    
  end
  
  def cart_item_by_product(product)
  	for cart_item in cart_items do
		  return cart_item if cart_item.product == product
	  end
		return nil
  end

  def remove(id)
    cart_items.delete cart_items[id]
  end
  
  def total_price
    total = 0
    cart_items.each { |item| total += item.total_price }
    total
  end

end
