class CartItem
  
  attr_accessor :id, :product_id, :quantity

  def initialize(id, product_id, quantity)
    @id = id
    @product_id = product_id
    @quantity = quantity
  end

  def product
    Product.find(@product_id)
  end

  def total_price
    product.price * @quantity
  end

end
