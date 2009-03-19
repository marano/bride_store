class ListsController < ApplicationController

  before_filter :login_required, :except => ['new', 'create', 'find', 'store', 'visit_list']

  layout 'site'

  def edit_nomes
  end

  def edit_personal_space
  end

  def personal_space
    @list = List.find(params[:id])
  end

  def store
    @list = List.first(:conditions => { :adress => params[:adress] })
    if @list.nil?
      redirect_to :back
      flash[:error] = 'Não foi possível localizar a loja!'
    else
      if logged_in?
        if @list.user == current_user
          set_current_store nil
          set_current_list @list
        else
          set_current_list nil
          set_current_store @list
        end
      else
        set_current_store @list
      end
      render :personal_space
    end
  end

  def select  
    set_current_store nil
    set_current_list List.find params[:id]
    redirect_to personal_space_list_path(current_list)    
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
          if(@list.list_items.empty?)
            redirect_to list_items_path
          else
            redirect_to personal_space_list_path(@list)
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
end
