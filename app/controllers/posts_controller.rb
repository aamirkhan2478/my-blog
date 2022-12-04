class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:author)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
    @comments = @post.comments.includes(:post)
   end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to user_posts_path(current_user.id)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
