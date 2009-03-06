module ProductsHelper

  def order_by_products
    order = session[:order_by_products]
    if order.blank?
      'name'
    else
      order
    end
  end
  
  def per_page_products
    per_page = session[:per_page_products]
    if per_page.blank?
      '4'
    else
      per_page
    end
  end

end
