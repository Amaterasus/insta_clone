class UsersController < ApplicationController
    before_action :authorized, only: [:index, :show, :edit, :update, :destroy]

    def create
        @user = User.create user_params
    end

    def destroy
    end

    private

    def find_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:user_name, :password, :password_confirmation, :bio)
    end

end
