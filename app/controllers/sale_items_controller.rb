class SaleItemsController < ApplicationController

  def index
    @store = current_list
  end
  
  def change
    @sale_item = SaleItem.find(params[:id])
    if @sale_item.change(params[:quantity].to_i)
      flash[:notice] = 'Produtos trocados com sucesso!'
    else
      flash[:error] = 'Não foi possível trocar o produto!'
    end
    redirect_to sale_items_path
  end

end
