class CartController < ApplicationController
  
  layout 'site'
  
  def show
    @cart = current_cart
  end

  def add
    product = Product.find(params[:product_id])
    current_cart.add(product, params[:quantity].to_i)
    flash[:notice] = "#{product.name} foi adicionado ao carrinho."
    redirect_to cart_path
  end

  def remove
    product = current_cart.remove(params[:id].to_i).product
    flash[:notice] = "#{product.name} foi removido do carrinho."
    redirect_to cart_path
  end
  
  def checkout
    @user = User.new
  end

end
