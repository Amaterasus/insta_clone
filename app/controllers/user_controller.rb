class UserController < ApplicationController

    def create
    end

    def destroy
    end

    private

    def find_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:user_name, :bio)
    end

end
