class Cart

  def cart_items
    @cart_items ||= []
  end
  
  def add(product, quantity)
    cart_items << CartItem.new(cart_items.size, product.id, quantity)
  end

  def remove(id)
    cart_items.delete cart_items[id]
  end
  
  def clear
    @cart_items = nil
  end
  
  def total_price
    total = 0
    cart_items.each { |item| total += item.total_price }
    total
  end

end
