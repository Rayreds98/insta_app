class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
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
      redirect_to root_path
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
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
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit!
  end

end
