class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:notice] = "ユーザーをフォローしました"
      redirect_to users_path
    else
      flash.now[:error] = following.errors.full_messages.to_sentence
      redirect_to users_path
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:notice] = "ユーザーをフォローを解除しました"
      redirect_to users_path
    else
      flash.now[:error] = following.errors.full_messages.to_sentence
      redirect_to users_path
    end
  end

  private

  def set_user
    @user = User.find(params[:followed_id])
  end
end
