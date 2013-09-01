module SessionsHelper
  def sign_in(user)
    token = User.new_token
    cookies.permanent[:remember_token] = token
    user.update_attribute(:remember_token, User.encrypt_token(token))
    self.current_user = user
  end

	def current_user=(user)
    @current_user = user
  end

	def current_user
		@current_user ||= nil
    token = User.encrypt_token(cookies[:remember_token]) 	if cookies[:remember_token].present?
    @current_user ||= User.find_by(remember_token: token) if token.present?
  end

	def signed_in?
    current_user.present?
  end
end
