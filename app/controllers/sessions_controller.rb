class SessionsController < ApplicationController

    def new 

    end 

    def create 
        #raise cookies.inspect
        # raise "stop".inspect
            #request.env
            #request.class
            #request.env["omniauth.auth"]
            #request.env["omniauth.auth"]["provider"]
            #request.env["omniauth.auth"]["uid"]
            #request.env["omniauth.auth"].keys
            #request.env["omniauth.auth"]["credentials"].keys
            #request.env["omniauth.auth"]["token"] - allows you to make request ot gihub on user behalf - create a repo on user behalf for example
        if auth_hash = request.env["omniauth.auth"] 
                #they loggedin omniauth
                #raise auth_hash.inspect
            oauth_username = request.env["omniauth.auth"]["info"]["nickname"]
            if user = User.find_by(:username => oauth_username) #github
                session[:user_id] = user.id
                redirect_to lists_path
            else 
                #I know them but this is the first time they came to this website
                # raise "NEW USER LOGGING IN VIA GITHUB".inspect
                user = User.create(:name => oauth_username, :username => oauth_username,:password => SecureRandom.hex)
                session[:user_id] = user.id
                redirect_to lists_path
            end 
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
