class ProductsController < ApplicationController

  layout 'adm'

  before_filter :login_required, :except => ['find', 'view']

  def view
    @product = Product.find params[:id]
    render :layout => 'site'
  end

  def find
    verify_list_products_options
    
    if params[:search].blank?
      if params[:category_id_filter].blank?
        @products = Product.paginate :page => params[:page], :order => order, :per_page => per_page
      else
        @category_filter = Category.find(params[:category_id_filter])
        @products = Product.paginate :page => params[:page], :order => order, :per_page => per_page, :conditions => { :category_id => @category_filter.id }
      end
    else
      @search = params[:search]
      s = @search.canonical
      
      s = s.split ' '
      sql_search = ''      
      for trecho in s
        next if trecho.blank?
        trecho.gsub!(/ /,'')
        unless sql_search.blank?
          sql_search << ' AND '
        end
        sql_search << "canonical_name like'%#{trecho}%'"
      end
      
      if params[:category_id_filter].blank?
        @products = (Product.paginate :page => params[:page], :order => order, :per_page => per_page, :conditions => sql_search)
      else
        @category_filter = Category.find(params[:category_id_filter])
        @products =  (Product.paginate :page => params[:page], :order => order, :per_page => per_page, :conditions => "category_id = #{@category_filter.id} AND #{sql_search}")
      end
    end
    render :layout => 'site'
  end

#  def find
#    if params[:search].blank?
#      if params[:category_id_filter].blank?
#        @products = Product.all
#      else
#        @products = Product.all :conditions => { :category_id => params[:category_id_filter] }
#      end
#    else
#      buscas = params[:search].split ' '
#      resultados = []
#      for b in buscas do
#        #b.low
#        if params[:category_id_filter].blank?
#          resultados << (Product.all :conditions => { :canonical_name => '%#{params[:search]}%' })
#        else
#          resultados << (Product.all :conditions => { :category_id => params[:category_id_filter], :canonical_name => '%#{params[:search]}%' })
#        end
#      end
#      @products = []
#      for r in resultados do
#        for p in r do
#          ok = true
#          for r1 in resultados do
#            unless r1 == r || r1.include?(p)
#              ok = false
#              break
#            end
#          end
#          if ok
#            unless @products.include? p
#              @products << p
#            end
#          end
#        end
#      end
#    end
#    render :layout => 'site'
#  end

  # GET /products
  # GET /products.xml
  def index
    @products = Product.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
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
        flash[:notice] = 'Product was successfully created.'
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
        flash[:notice] = 'Product was successfully updated.'
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

