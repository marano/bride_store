class ProductsController < ApplicationController

  layout 'adm'

  before_filter :adm_required, :except => ['find', 'view']
  
  sortable_attributes :name, :price, :featured

  def view
    @product = Product.find params[:id]
    render :layout => 'site'
  end

  def find
    verify_list_products_options
    
    sql_conditions = ''
    
    unless params[:search].blank?
      @search = params[:search]
            
      splited = @search.canonical.split ' '
      sql_search = ''      
      for trecho in splited
        next if trecho.blank?
        trecho = trecho.trim
        unless sql_search.blank?
          sql_search << ' AND '
        end
        sql_search << "canonical_name like '%#{trecho}%'"
      end
      
      unless sql_conditions.blank?
          sql_condition << ' AND '
      end
      
      sql_conditions << sql_search
    end
    
    unless params[:category_id_filter].blank?
      @category_filter = Category.find(params[:category_id_filter])
      
      unless sql_conditions.blank?
          sql_conditions << ' AND '
      end
      
      sql_conditions << "category_id = #{@category_filter.id}"
    end
    
    search_params = { :page => params[:page], :order => order, :per_page => per_page, :conditions => sql_conditions }
    
    @products = user_session.find_store_products(search_params)
    
    render :layout => 'site'
  end

  # GET /products
  # GET /products.xml
  def index
    @products = Product.paginate :page => params[:page], :order => params[:sort], :per_page => 30
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        save_success
        format.html { redirect_to(@product) }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        save_success
        format.html { redirect_to(@product) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = 'Produto removido com sucesso!'
    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def verify_list_products_options
    unless params[:order].blank?
      session[:order_by_products] = params[:order]
    end
    unless params[:per_page].blank?
      session[:per_page_products] = params[:per_page]
    end
  end
  
  def order
    order = session[:order_by_products]
    if order.blank?
      'name'
    else
      order
    end
  end
  
  def per_page
    per_page = session[:per_page_products]
    if per_page.blank?
      '4'
    else
      per_page
    end
  end
end

