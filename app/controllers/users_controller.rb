class UsersController < ApplicationController
    def new
        @user = User.new
    end 

    def create
        #byebug
        @user = User.new(user_params)
        if @user.save 
            session[:user_id] = @user.id #logs in the user -- tells app that user is logged in
            redirect_to lists_path
        else 
            render :new
        end 
        
    end 

    private 

    def user_params
        params.require(:user).permit(:name, :username, :password)
    end 
end
