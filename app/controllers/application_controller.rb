class ApplicationController < ActionController::Base
    helper_method :logged_in?
    helper_method :current_user

    private

    def logged_in?
        # !!session[:user_id]
        !!current_user
    end 

    def current_user
        User.find_by(id: session[:user_id])
    end 

    def log_in(user)
        session[:user_id] = user.id
    end 

    def authenticate
        redirect_to login_path if !logged_in?
    end 

    
end
