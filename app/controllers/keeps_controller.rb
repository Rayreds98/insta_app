class KeepsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]

  def index
    @user = User.find_by(id: params[:user_id])
    @keeps = current_user.keep_posts.order('created_at desc')
  end

  def create
    keep = current_user.keeps.create(post_id: params[:post_id])
    redirect_to root_path
  end

  def destroy
    keep= current_user.keeps.find_by(post_id: params[:post_id]).destroy
    redirect_to root_path
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end
  end

end
