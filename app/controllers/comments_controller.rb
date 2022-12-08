class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comments = Comment.new
  end

  def create
    @current_post = Post.find(params[:post_id])
    @comments = @current_post.comments.new(comment_params)
    @comments.post_id = @current_post.id
    @comments.author_id = current_user.id
    if @comments.save
      redirect_to user_post_path(@current_post.author_id, @current_post.id)
    else
      render :new
    end
  end

  def destroy
    @current_post = Post.find(params[:post_id])
    @current_comment = @current_post.comments.find(params[:id])
    @current_comment.destroy
    if @current_comment.destroy
      @current_comment.update_comment_counter_when_comment_deleted
      redirect_to user_post_path(@current_post.author_id, @current_post.id)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
