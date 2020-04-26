module SessionsHelper

  # ログイン(一時セッション)
  def log_in(user)
    # セッションは自動でユーザーIDが暗号化される
    session[:user_id] = user.id
  end

  # ログイン（永続セッション）
  def remember(user)
    user.remember
    # ユーザーIDの暗号化
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # paramsのユーザーとログインユーザーが一致しているかどうか真偽
  def current_user?(user)
    user == current_user
  end

  # 現在のログインユーザーを取得する
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ログインしているかどうか検証し真偽で返す
  def logged_in?
    !current_user.nil?
  end

  # 永続セッションの破棄
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    # 永続セッションの破棄
    forget(current_user)
    # 一時セッションの破棄
    session.delete(:user_id)
    @current_user = nil
  end

  # 記憶したURLもしくはデフォルト値にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
