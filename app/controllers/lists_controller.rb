class ListsController < ApplicationController

    def index
        @lists = List.all
    end 

    def show
        @list = List.find_by(params[:id])
    end 
end
