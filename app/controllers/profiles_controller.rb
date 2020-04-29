class ProfilesController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :set_profile, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def edit
  end

  def update
    if @profile.update_attributes(profile_params)
      flash[:success] = 'Profile was successfully updated.'
      binding.pry
      redirect_to @user
    else
      flash.now[:error] = @profile.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:name, :biography, :birthday, :website, :user_id, :created_at, :update_at, :icon)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end
  end

  def correct_user
    @user = @profile.user
    redirect_to(root_url) unless current_user?(@user)
  end

end
