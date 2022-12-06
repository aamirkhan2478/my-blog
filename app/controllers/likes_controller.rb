class LikesController < ApplicationController
  before_action :authenticate_user!
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(author_id: current_user.id, post_id: @post.id)

    if @like.save
      redirect_to user_post_path(@post.author_id, @post.id)
    else
      render :new
    end
  end
end
