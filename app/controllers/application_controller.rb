class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user, :is_user?, :is_followed_by?

    def current_user
        # In sessions updates the user to be this user
        if session[:user_id]
            @current_user = User.find(session[:user_id])
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

    def is_followed_by?(page_user)
        if Follow.select { |f| (f.follower == current_user) && (f.followee == page_user) } == []
            # Be able to follow
            false
        else
            # Be able to unfollow
            true
        end
    end

    def is_user?(page_user)
        if page_user.id == current_user.id 
            # If true will be able to edit profile but not follow
            # And vice versa
            true
        else
        end
    end

end
