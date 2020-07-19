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

  def update #PATCH /lists/:list_id/items/:id
    #What item am i trying to update?

    @item = Item.find(params[:id])
    @item.update(item_params)
    # @item.status = params[:item][:status]
    # @item.save

    redirect_to list_path(@item.list)
    # @list = List.find(params[:id])
    # @item = @list.items.find(params[:id])
  #raise params.inspect #the data the form submitted
  # Can use that data to update the item described in the URL

  end 

  private 
  def item_params
    params.require(:item).permit(:description, :status)
  end
end
