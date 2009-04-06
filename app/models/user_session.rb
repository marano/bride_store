class UserSession

  def initialize(session)
    @session = session
  end

  def store_categories
    if current_store.nil? or current_store.closed    
      if logged_in? and current_user == current_store.user
        Category.all
      else
        current_store.categories
      end      
    else
      current_store.categories
    end
  end

  def show_list_menu_panel?
    !current_list.nil? and !current_list.closed
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

