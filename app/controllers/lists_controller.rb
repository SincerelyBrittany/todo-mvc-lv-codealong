class ListsController < ApplicationController

    def index
        @list = List.new
        @lists = List.all
    end 

    def show
        @list = List.find(params[:id])
        #params is going to have all the data passed by the user - params is a hash
    end 

    def create
        # raise params.inspect
        # @list = List.new
        # @list.name = params[:list][:name]
        # @list.save

        # redirect_to list_path(@list)

        @list = List.create(list_params)
        redirect_to list_path(@list)
    end

    private 
    def list_params
        params.require(:list).permit(:name)
    end

end
