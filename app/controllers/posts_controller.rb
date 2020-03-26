class PostsController < ApplicationController
  before_action :authorized
  before_action :find_post, only: [:show, :edit, :update, :like, :unlike, :post_likes]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(new_post_params)
    @post.user = current_user

    if @post.save
      redirect_to @post
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    @post.update(edit_post_params)

    if @post.valid?
      redirect_to @post
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def like
    Like.create(user: current_user, post: @post)
    redirect_to @post
  end

  def unlike
    Like.find_by(user: current_user, post: @post).destroy
    redirect_to @post
  end

  def post_likes
      @users = Like.select{|l| l.post == @post }
      render :post_likes
  end 

  def destroy
  end

  private

  def find_post
    @post = Post.find_by(id: params[:id])
  end

  def new_post_params
    params.require(:post).permit(:title, :image)
  end

  def edit_post_params
    params.require(:post).permit(:title)
  end

end
