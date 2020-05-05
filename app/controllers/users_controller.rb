class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end

  def new
    @user = User.new
  end

  def show
    @posts = @user.posts
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.build_profile
    if @user.save
      @user.send_activation_email
      flash[:notice] = "Please check your email to activate your account."
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

  def following
    @following = current_user.following.paginate(page: params[:page], per_page: 15)
  end

  def followers
    @followers = current_user.followers.paginate(page: params[:page], per_page: 15)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
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
