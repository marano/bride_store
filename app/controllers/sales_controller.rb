class SalesController < ApplicationController

  layout 'adm'

  before_filter :adm_required, :except => [ :new, :create ]

  def pay
    @sale = Sale.find(params[:id])
    @sale.pay
    redirect_to sales_path
  end

  def index
    set_date_filter    
    
    @sales = Sale.all(:conditions => ['created_at > ? AND created_at < ?', @initial_date_filter, (@end_date_filter + 1.day)])
  end

  def show
    @sale = Sale.find(params[:id])
  end

  def new
    @sale = Sale.new

    respond_to do |format|
      format.html { render :layout => 'application' }
      format.xml  { render :xml => @sale }
    end
  end

  def create
    @sale = Sale.new(params[:sale])
    @sale.store = current_store    
    @sale.extract(current_cart)    
    user_session.clear_cart    
    
    if @sale.save
      redirect_to send_visanet_path(@sale.id)
    else
      render :action => "new"
    end
  end

  #  # PUT /sales/1
  #  # PUT /sales/1.xml
  #  def update
  #    @sale = Sale.find(params[:id])

  #    respond_to do |format|
  #      if @sale.update_attributes(params[:sale])
  #        flash[:notice] = 'Sale was successfully updated.'
  #        format.html { redirect_to(@sale) }
  #        format.xml  { head :ok }
  #      else
  #        format.html { render :action => "edit" }
  #        format.xml  { render :xml => @sale.errors, :status => :unprocessable_entity }
  #      end
  #    end
  #  end

  # DELETE /sales/1
  # DELETE /sales/1.xml
  def destroy
    @sale = Sale.find(params[:id])

    @sale.destroy

    redirect_to(sales_url)
  end
  
  private
  
  def set_date_filter
    if params[:date_filter]
      begin
        @initial_date_filter = Date.new(params[:date_filter][:"initial(1i)"].to_i,params[:date_filter][:"initial(2i)"].to_i,params[:date_filter][:"initial(3i)"].to_i)
        @end_date_filter = Date.new(params[:date_filter][:"end(1i)"].to_i,params[:date_filter][:"end(2i)"].to_i,params[:date_filter][:"end(3i)"].to_i)
      rescue => e
        @initial_date_filter = 1.month.ago
        @end_date_filter = Date.today
        flash[:error] = 'Data inválida!'
      end
    else
      @initial_date_filter = 1.month.ago
      @end_date_filter = Date.today
    end
  end
end

