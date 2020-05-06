class FavoritesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]


  def create
    favorite = current_user.favorites.create(post_id: params[:post_id])
    redirect_to home_path
  end

  def destroy
    favorite = current_user.favorites.find_by(post_id: params[:post_id]).destroy
    redirect_to home_path
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
