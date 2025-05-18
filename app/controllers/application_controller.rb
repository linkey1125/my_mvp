class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  allow_browser versions: :modern

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def authenticate_user!
    redirect_to login_path, alert: "ログインが必要です" unless logged_in?
  end
end
