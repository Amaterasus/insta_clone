class UsersController < ApplicationController
  before_action :authorized, only: [:index, :show, :edit, :update, :destroy]
  before_action :find_user, only: [:show, :follow, :unfollow]

  def create
    @user = User.create user_params
    @user.user_name = @user.user_name.downcase
    @user.save
    session[:user_id] = @user.id
    redirect_to edit_user_path(@user)
  end

  def show
    @posts = Post.where(user_id: @user.id)
  end

  def destroy
  end

  def follow
    Follow.create(follower: current_user, followee: @user)
    redirect_to @user
  end

  def unfollow
    Follow.find_by(follower: current_user, followee: @user).destroy
    redirect_to @user
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :password, :password_confirmation, :bio)
  end
end
