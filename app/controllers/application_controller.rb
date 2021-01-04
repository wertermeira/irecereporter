class ApplicationController < ActionController::Base
  helper_method :current_user

  def index
    redirect_to new_session_path if current_user.blank?
  end

  private

  def require_login
    redirect_to new_session_path unless current_user
  end

  def current_user
    user = Admin.find_by(id: session[:user_id])
    @current_user ||= user if session[:user_id] && user
  end
end
