class ItemsController < ApplicationController
  def create
    #raise params.inspect
    @list = List.find(params[:list_id]) #finding the parent 
    # @item = Item.new(items_params)
    @item = @list.items.build(item_params)
    #raise @item.inspect
    if @item.save
    redirect_to list_path(@list)
    else
      render "lists/show"
    end
  end

  private 
  def item_params
    params.require(:item).permit(:description)
  end
end
