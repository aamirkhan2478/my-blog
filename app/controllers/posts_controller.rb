class PostsController < ApplicationController
  def index
    @user = User.find(params[:author_id])
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:author_id])
    @comments = @post.comments
  end
end
