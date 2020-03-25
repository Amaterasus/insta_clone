class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    def current_user
        # In sessions updates the user to be this user
        if session[:user_id]
            @user = User.find(session[:user_id])
        else
        end
    end

    def logged_in?
        # Converts current user to boolean
        !!current_user
    end

    def authorized
        # If allowed to be on site
        unless logged_in?
            flash[:errors] ||= []
            flash[:errors] << "You must Log In to use InstaClone."
            redirect_to login_path
        end
    end

end
