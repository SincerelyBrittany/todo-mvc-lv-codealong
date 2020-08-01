class ListsController < ApplicationController
    before_action :authenticate

    def index
        @list = List.new
        @lists = List.all
    end 

    def show
        @list = List.find(params[:id])
        # @item = @list.items.build
        @item = Item.new
        #params is going to have all the data passed by the user - params is a hash
    end 

    def create
        # raise params.inspect
        # @list = List.new
        # @list.name = params[:list][:name]
        # @list.save

        # redirect_to list_path(@list)

        @list = List.create(list_params)
        if @list.save
            redirect_to list_path(@list)
        else 
            @lists = List.all
            #render does not make another request
            render :index
        end
    end

    def edit 
        byebug
    end 

    def update 
       byebug 
    end 
    private 
    def list_params
        params.require(:list).permit(:name)
    end

end
