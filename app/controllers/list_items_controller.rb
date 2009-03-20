class ListItemsController < ApplicationController

  layout 'site'

  # GET /list_items
  # GET /list_items.xml
  def index
    @list = current_list
  end
  
  def cart
    @list = current_store
    render :action => 'index'
  end

  # GET /list_items/1
  # GET /list_items/1.xml
  def show
    @list_item = ListItem.find(params[:id])
  end

  # GET /list_items/new
  # GET /list_items/new.xml
  def new
    @list_item = ListItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @list_item }
    end
  end

  # GET /list_items/1/edit
  def edit
    @list_item = ListItem.find(params[:id])
  end

  # POST /list_items
  # POST /list_items.xml
  def create
    product = Product.find(params[:list_item][:product_id])
    current_list.add_list_item(product, params[:list_item][:quantity])
    
    flash[:notice] = 'Produto adicionado.'
    redirect_to(list_items_path)
  end

  # PUT /list_items/1
  # PUT /list_items/1.xml
  def update
    @list_item = ListItem.find(params[:id])

    respond_to do |format|
      if @list_item.update_attributes(params[:list_item])
        flash[:notice] = 'Lista atualizada.'
        format.html { redirect_to :back }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @list_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /list_items/1
  # DELETE /list_items/1.xml
  def destroy
    @list_item = ListItem.find(params[:id])
    @list_item.destroy
    flash[:notice] = 'Produto removido.'
    redirect_to(list_items_path)
  end
end

