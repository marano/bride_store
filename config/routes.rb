ActionController::Routing::Routes.draw do |map|
   
  map.root :controller => 'site', :action => 'home'
  map.home '/home', :controller => 'site', :action => 'home'
  map.we '/we', :controller => 'site', :action => 'we'
  map.showroom '/showroom', :controller => 'site', :action => 'showroom'
  map.adm '/adm', :controller => 'adm', :action => 'home'
  
  map.fale_conosco '/fale_conosco', :controller => 'fale_conosco', :action => 'new'
  map.send_fale_conosco '/fale_conosco/send', :controller => 'fale_conosco', :action => 'enviar'
    
  map.edit_home '/adm/home', :controller => 'site_adm', :action => 'home'
  map.edit_we '/adm/we', :controller => 'site_adm', :action => 'we'
  map.edit_showroom '/adm/showroom', :controller => 'site_adm', :action => 'showroom'
  map.edit_site_data '/adm/site_data', :controller => 'site_adm', :action => 'site_data'
  map.edit_footer '/adm/footer', :controller => 'site_adm', :action => 'footer'
  map.edit_logo '/adm/logo', :controller => 'site_adm', :action => 'logo'
  
  map.find_list '/lists/find', :controller => 'lists', :action => 'find'
  map.edit_list_nomes '/list/edit_nomes', :controller => 'lists', :action => 'edit_nomes'
  map.edit_list_personal_space '/list/edit_personal_space', :controller => 'lists', :action => 'edit_personal_space'
  map.select_list '/list/:id/select', :controller => 'lists', :action => 'select'
  map.confirm_close_list '/list/confirm_close', :controller => 'lists', :action => 'confirm_close'
  map.close_list '/list/close', :controller => 'lists', :action => 'close'
  map.new_delivery 'list/delivery/new', :controller => 'lists', :action => 'new_delivery'
  map.create_delivery 'list/delivery', :controller => 'lists', :action => 'create_delivery', :conditions => { :method => :post}
  map.delivery 'list/delivery/:id', :controller => 'lists', :action => 'show_delivery'
  map.deliveries 'list/deliveries', :controller => 'lists', :action => 'deliveries'
  map.exit_list 'list/exit', :controller => 'lists', :action => 'exit'
  
  map.set_list_item_quantity '/set_list_item_quantity/:id', :controller => 'list_items', :action => 'set_list_item_quantity'
  
  map.destroy_galery_photo '/galery_photo/:id/destroy', :controller => 'galery_photos', :action => 'destroy'
  
  map.edit_email_config '/email_config/edit', :controller => 'email_configs', :action => 'edit'
  
  map.change_quantity_list_item '/list_item/:id/change_quantity', :controller => 'list_items', :action => 'update'
  
  map.view_testimonials '/testimonials/view', :controller => 'testimonials', :action => 'view'
  
  map.new_admin '/user/adm/new', :controller => 'users', :action => 'new_admin'
  map.create_admin '/user/adm/create', :controller => 'users', :action => 'create_admin'
  map.update_admin '/user/adm/:id/update', :controller => 'users', :action => 'update_admin'
  
  map.cart '/cart', :controller => 'cart', :action => 'show'
  map.add_to_cart '/cart/:product_id/add', :controller => 'cart', :action => 'add'
  map.change_quantity_cart_item '/cart/:product_id', :controller => 'cart', :action => 'set', :conditions => { :method => :put }
  map.remove_from_cart '/cart/:id/remove', :controller => 'cart', :action => 'remove'
  
  map.checkout '/cart/checkout', :controller => 'sales', :action => 'new'
  
  map.resources :sales, :except => [ :edit ], :member => { :pay => :put, :capture => :put, :archive => :put }
  map.resources :sale_items, :only => [ :index ], :member => [ :change ]
  map.resources :email_configs
  map.resources :spams, :member => [ :enviar ]
  map.resources :galery_photos
  map.resources :messages
  map.resources :lists, :member => [ :personal_space, :archive ]   
  map.resources :list_items
  map.resources :testimonials
  map.resources :policies, :collection => [ :view ]
  map.resources :products, :collection => [ :find ], :member => [ :view, :destroy_photo, :destroy_display ]
  map.resources :categories
  map.resources :mails, :member => [ :enviar ]
  
  map.add_mail 'mails/add', :controller => 'mails', :action => 'add'
  map.remove_mail 'mails/:id/remove', :controller => 'mails', :action => 'remove'
  
  map.send_visanet '/visanet/:sale_id/send', :controller => 'visanet', :action => 'send_to_payment'
  map.resend_visanet '/visanet/:sale_id/resend', :controller => 'visanet', :action => 'resend'
  map.confirm_visanet '/visanet/confirm', :controller => 'visanet', :action => 'confirm'
  map.complete_visanet '/visanet/complete', :controller => 'visanet', :action => 'complete', :conditions => { :method => :post }
  map.send_capture_visanet '/visanet/:sale_id/capture/send', :controller => 'visanet', :action => 'send_to_capture'
  map.complete_capture '/visanet/capture', :controller => 'visanet', :action => 'complete_capture', :conditions => { :method => :post }
  
  map.resources :users, :member => { :suspend   => :put,
                                   :unsuspend => :put,
                                   :purge     => :delete }

  map.resources :sites, :controller => 'site', :only => [:update]
  map.resource :session
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.account '/account', :controller => 'users', :action => 'account'
  map.account_list '/account', :controller => 'users', :action => 'account_list'
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.send_password '/send_password', :controller => 'users', :action => 'send_password'

  map.my_list '/my_list', :controller => 'lists', :action => 'my_list'
  map.visit_list '/visit_list', :controller => 'lists', :action => 'visit_list'
  
  map.store '/:adress', :controller => 'lists', :action => 'store'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
