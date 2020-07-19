class ListsController < ApplicationController

    def index
        @lists = List.all
    end 

    def show
        @list = List.find(params[:id])
        #params is going to have all the data passed by the user - params is a hash
    end 
end
