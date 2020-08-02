class SessionsController < ApplicationController

    def new 

    end 

    def create 
        if auth_hash = request.env["omniauth.auth"] 
            user = User.find_or_create_by_omniauth(auth_hash)
                session[:user_id] = user.id
                redirect_to lists_path
        else
            #normal log in
            @user = User.find_by(username: params[:username])
            #cookies[:username] = @user.email
            if @user && @user.authenticate(params[:password])
                # session[:user_id]
                log_in(@user)
                flash[:sucess] = "Welcome, #{@user.username}"
                redirect_to lists_path
            else 
                flash[:danger] = "Improper credentials given"
                redirect_to login_path
            end 
        end
    end 

    def destroy 
        # byebug
        session.clear 
        redirect_to login_path
    end 
end
