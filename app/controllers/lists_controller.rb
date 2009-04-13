class ListsController < ApplicationController

  before_filter :login_required, :except => ['find', 'store', 'visit_list']
  before_filter :adm_required, :only => [ 'deliveries', 'show_delivery' ]

  def show_delivery
    @delivery = List.find(params[:id])
    render :layout => 'adm'
  end

  def deliveries
    set_date_filter

    @deliveries = List.scoped_by_delivery(true).all(:conditions => ['delivery_date > ? AND delivery_date < ?', @initial_date_filter, (@end_date_filter + 1.day)])

    render :layout => 'adm'
  end

  def new_delivery
    @list = current_list
  end

  def create_delivery
    @list = current_list
    @list.delivery_adress = params[:delivery_adress]
    @list.delivery_date = Date.new(params[:delivery_date][:year].to_i, params[:delivery_date][:month].to_i, params[:delivery_date][:day].to_i)
    @list.delivery = true
    @list.save!
    redirect_to account_path
  end

  def confirm_close
    @list = current_list
  end

  def close
    current_list.update_attribute(:closed, true)
    redirect_to select_list_path(current_list)
  end

  def my_list
    if current_list.nil?
      redirect_to new_list_path
    else
      redirect_to personal_space_list_path(current_list)
    end
  end

  def edit_nomes
    @list = current_list
  end

  def edit_personal_space
    @list = current_list
  end

  def personal_space
    @list = List.find(params[:id])
  end

  def select
    user_session.select_list List.find(params[:id])
    redirect_to personal_space_list_path(current_list)
  end

  def store
    @list = List.first(:conditions => { :adress => params[:adress] })
    if @list.nil?
      redirect_to root_path
      flash[:error] = "Não foi possível localizar a loja #{params[:adress]}."
    else
      user_session.select_list @list
      render :personal_space
    end
  end

  def find
    if params[:search].blank?
      flash[:error] = 'Digite um nome para a busca!'
      redirect_to :back
      return
    end

    search = params[:search].canonical
    @list = List.first :conditions => "#{params[:name_filter]}_busca LIKE '#{search}'"
    if @list
      redirect_to store_path(@list.adress)
    else
      flash[:error] = "Não foi possível localizar a lista de #{search}"
      redirect_to home_path
    end
  end

  # GET /lists
  # GET /lists.xml
  def index
    @lists = List.find(:all)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.xml
  def show
    @list = List.find(params[:id])
  end

  # GET /lists/new
  # GET /lists/new.xml
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
  end

  # POST /lists
  # POST /lists.xml
  def create
    @list = List.new(params[:list])
    @list.user = current_user
    if @list.save
      set_current_list @list
      flash[:notice] = 'Lista criada com sucesso!'
      redirect_to edit_list_nomes_path
    else
      render :action => "new"
    end
  end

  # PUT /lists/1
  # PUT /lists/1.xml
  def update
    @list = List.find(params[:id])

    params[:list].delete :photo if params[:list][:photo].blank?

    if @list.update_attributes(params[:list])
      flash[:notice] = 'Lista salva com sucesso!'

      unless params[:edit_what].blank?
        case params[:edit_what]
        when 'nomes'
          redirect_to edit_list_personal_space_path
        when 'personal_space'
          if params[:list][:photo]
            redirect_to edit_list_personal_space_path
          else
            if(@list.list_items.empty?)
              redirect_to list_items_path
            else
              redirect_to personal_space_list_path(@list)
            end
          end
        end
      else
        redirect_to(@list)
      end
    else
      render :action => "edit"
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.xml
  def destroy
    @list = List.find(params[:id])
    if current_list? @list
      set_current_list nil
    end
    @list.destroy
    flash[:notice] = 'Lista removida com sucesso!'
    redirect_to(new_list_path)
  end

  private

  def set_date_filter
    if params[:initial_date_filter] and params[:end_date_filter]
      begin
        @initial_date_filter = Date.new(params[:initial_date_filter][:year].to_i, params[:initial_date_filter][:month].to_i, params[:initial_date_filter][:day].to_i)
        @end_date_filter = Date.new(params[:end_date_filter][:year].to_i, params[:end_date_filter][:month].to_i, params[:end_date_filter][:day].to_i)
      rescue => e
        @initial_date_filter = 1.month.ago
        @end_date_filter = Date.today + 1.month
        flash[:error] = 'Data inválida!'
      end
    else
      @initial_date_filter = 1.month.ago
      @end_date_filter = Date.today + 1.month
    end
  end
end

