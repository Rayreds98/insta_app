class AccountActivationsController < ApplicationController

  # メール認証ができたら(有効化トークンとDBの有効化ダイジェストの一致)DBのactivatedを変更する
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
