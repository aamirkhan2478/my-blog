class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.includes(:posts).where("id = #{params[:user_id]}").first
    @post = @user.posts.filter { |post| post.id = params[:id] }.first
    @comments = Comment.includes(:author)
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
