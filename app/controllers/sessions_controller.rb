class SessionsController < ApplicationController
  def create
    @validation = LoginValidation.new(session_params)
    if @validation.valid?
      user = Admin.find_by(email: session_params.dig('email').downcase)
      return login_success(user) if user.authenticate(session_params.dig('password'))

      @validation.errors.add(:password, 'Senha incorreta')
    end
    render :index
  end

  def destroy
    session[:admin_id] = nil
    redirect_to sessions_path
  end

  private

  def login_success(user)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end