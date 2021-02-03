module ControllerHelpers
  def login_admin(admin)
    post sessions_path, params: {login: {email: admin.email, password: '123456'}}

    page.set_rack_session(:admin_id => @admin.id)
  end

  def logout
    session.delete(:admin_id)
  end

  def current_admin
    Admin.find(session[:admin_id]) if Admin.exists?(session[:admin_id]) && session[:admin_id]
  end

  def signed_in_admin?
    !!current_admin
  end
end
