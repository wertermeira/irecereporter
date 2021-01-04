class SessionsController < BackofficeController
  skip_before_action :require_login, only: %i[new create]
  layout 'layout_session'

  def new
    redirect_to backoffice_admins_path if current_user.present?
  end

  def create
    @validation = LoginValidation.new(session_params)
    if @validation.valid?
      user = Admin.find_by(email: session_params.dig('email').downcase)
      return login_success(user) if user.authenticate(session_params.dig('password'))

      @validation.errors.add(:password, 'Senha incorreta')
    end
    render :new
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  private

  def login_success(user)
    session[:user_id] = user.id
    redirect_to backoffice_posts_path
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end