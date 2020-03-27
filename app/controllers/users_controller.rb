class UsersController < ApplicationController
  before_action :authorized, only: [:index, :show, :edit, :update, :destroy, :user_followers, :user_followees ]
  before_action :find_user, only: [:show, :user_followers, :user_followees, :follow, :unfollow, :edit, :update]

  def edit
  end

  def update
    @user.update(edit_user_params)

    if @user.valid?
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def create
    @user = User.create user_params
   if @user.valid? 
    @user.user_name = @user.user_name.downcase
    @user.save
    session[:user_id] = @user.id
    redirect_to edit_user_path(@user)
   else 
    flash[:errors] = @user.errors.full_messages
    redirect_to signup_path
   end
  end

  def show
    @posts = Post.where(user_id: @user.id)
  end

  def destroy
  end

  def user_followers
    @users = Follow.select { |f| f.followee == @user }
    render :index
  end

  def user_followees
    @users = Follow.select { |f| f.follower == @user }
    render :followings
  end

  def follow
    Follow.create(follower: current_user, followee: @user)
    redirect_to @user
  end

  def unfollow
    Follow.find_by(follower: current_user, followee: @user).destroy
    redirect_to @user
  end

  def home
    @posts = current_user.followee_recent_posts
    render :'posts/index'
  end

  def explore
    # Sample randomly posts
    @posts = Post.explore_posts
    render :'posts/index'
  end

  def change_password 
  end 

  def update_password
    @user= current_user
    if @user.authenticate(params[:user][:current_password])
      if @user.update(update_password_params)
        flash[:errors] ||= []
        flash[:errors] << "Password Updated"
        redirect_to edit_user_path(@user)
      else 
        flash[:errors] = @user.errors.full_messages
        byebug
        redirect_to change_password_path
      end
    else 
      flash[:errors] ||= []
      flash[:errors] << "The password entered does not match your current password"
      redirect_to change_password_path
    end 
  end 

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :password, :password_confirmation, :bio)
  end

  def edit_user_params
    params.require(:user).permit(:bio)
  end

  def update_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end 
end
