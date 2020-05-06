class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    binding.pry
    if @comment.save
      redirect_to home_path
    else
      redirect_to home_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to home_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

end
