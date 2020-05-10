class CommentsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @comments = Comment.where(post_id: params[:post_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

end
