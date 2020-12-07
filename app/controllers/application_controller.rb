class ApplicationController < ActionController::Base
  def index
    redirect_to sessions_path if current_user.blank?
  end

  private

  def require_user
    redirect_to sessions_path unless current_user
  end

  def current_user
    user = Admin.find_by(id: session[:user_id])
    @current_user ||= user if session[:user_id] && user
  end
end
