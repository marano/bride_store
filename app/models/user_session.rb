class UserSession

  def initialize(session)
    @session = session
  end
  
  def can_add_to_cart?
    current_store and (current_store.open? or current_store.user == current_user)
  end
  
  def can_add_to_list?
    current_list and current_list.open?
  end

  def find_store_products(params)
    if current_store.nil? or current_store.closed?
      Product.paginate params
    else
      current_store.products.paginate params
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
  
  def show_checkout?
    !current_cart.cart_items.empty? or current_list
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
          self.current_store = list
          self.current_list = list
        else
          self.current_store = nil
          self.current_list = list
        end
      else
        self.current_store = list
        self.current_list = nil
      end
    else
      self.current_store = list
    end
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

end

