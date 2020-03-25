class SessionsController < ApplicationController

    def login
    end

    def signup
    end

    def logout
        # Changes session to nil i.e. logging out
        session[:user_id] = nil
        redirect_to login_path
    end

    def login_verify
        # Finds user by matching usernames passed in
        # Authenticates it with the password provided
        # Either says failed or goes to their 'home' page (and starts the session)
        @user = User.find_by(user_name: params[:user][:user_name].downcase)
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id 
            # Will put my followers posts path or soemthing like that
            redirect_to posts_path
        else
            flash[:errors] ||= []
            flash[:errors] << "Username or Password is incorrect. Please Try Again." 
            redirect_to login_path
        end
    end

end
