class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:notice] = 'アカウント登録完了'
      redirect_to root_url
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = 'アカウント編集完了'
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = 'アカウントを削除しました'
    redirect_to users_url
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
