class UserSession

  def initialize(session)
    @session = session
  end
  
  def show_quantities?
    current_list or current_store
  end
  
  def current_place
    current_list or current_store
  end
  
  def wished_quantity(product)
    query_list = current_place
    unless query_list.nil?
      item = query_list.item_by_product(product)
    end
    if item
      item.quantity
    else
      0
    end
  end
  
  def bought_quantity(product)
    query_list = current_place
    unless query_list.nil?
      item = query_list.item_by_product(product)
    end
    if item
      item.quantity_bought
    else
      0
    end
  end
  
  def show_edit_list?(list)
    !list.closed?
  end

  def can_add_to_cart?
    current_store and (current_store.open? or current_store.user == current_user) and !current_store.delivery
  end

  def can_add_to_list?
    current_list and current_list.open? and !current_list.delivery
  end

  def find_store_products(params)
    if current_store.nil?
      Product.scoped_by_active(true).paginate params
    else
      if current_store.user == current_user
        Product.scoped_by_active(true).paginate params
      else
        current_store.products.paginate params
      end
    end
  end

  def store_categories
    if current_store.nil?
      Category.all
    else
      if logged_in? and current_store.user == current_user
        Category.all
      else
        current_store.categories
      end
    end
  end
  
  def show_store_status?
    #logged_in? and current_user == current_store.user
    true
  end

  def show_credit?
    current_list and current_list.closed and has_credit? and current_store and !current_store.delivery
  end

  def show_checkout?
    !current_cart.cart_items.empty?
  end

  def show_deliver?
    current_store == current_list and current_store.has_gift_for_delivery?
  end

  def show_list_menu_panel?
    !current_list.nil? and current_list.open?
  end

  def show_store_menu_panel?
    !current_store.nil?
  end

  def select_list(list)
    if logged_in?
      if list.user == current_user
        if list.closed
          smart_select_list(list, list)
        else
          smart_select_list(nil, list)
        end
      else
        smart_select_list(list, nil)
      end
    else
      if current_store != list
        clear_cart
        self.current_store = list
        self.current_store = nil
      end
      smart_select_list(list, nil)
    end
  end
  
  def credit
    current_list ? current_list.credit : 0      
  end
  
  def has_credit?
    credit > 0
  end
  
  def total_price_to_pay
    if current_cart.total_price >= credit
      current_cart.total_price - credit
    else
      0
    end
  end
  
  def exit_list
    self.current_list = nil
    self.current_store = nil
    clear_cart
  end

  def current_store=(store)
    @current_store = store
    @session[:current_store] = store ? store.id : nil
  end

  def current_store
    @current_store ||= List.find(@session[:current_store]) unless @session[:current_store].nil?
  end

  def current_list=(list)
    @current_list = list
    @session[:current_list] = list ? list.id : nil
  end

  def current_list
    @current_list ||= List.find(@session[:current_list]) unless @session[:current_list].nil?
  end

  def current_list?(list)
    @session[:current_list] == list.id
  end

  def current_cart
    @current_cart ||= @session[:cart] ||= Cart.new(current_store)
  end

  def clear_cart
    @current_cart = nil
    @session[:cart] = nil
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= @session[:user_id] ? User.find(@session[:user_id]) : nil
  end
  
  private
  
  def smart_select_list(store, list)
    if current_store != store || current_list != list
      clear_cart
      self.current_store = store
      self.current_list = list
    end
  end

end

