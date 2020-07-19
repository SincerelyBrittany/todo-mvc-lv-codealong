class ItemsController < ApplicationController
  def create
    #raise params.inspect
    @list = List.find(params[:list_id]) #finding the parent 
    # @item = Item.new(items_params)
    @item = @list.items.build(item_params)
    #raise @item.inspect
    @item.save
    redirect_to list_path(@list)
  end

  private 
  def item_params
    params.require(:item).permit(:description)
  end
end
