class SessionsController < ApplicationController
  def new
    redirect_to user_todo_list_path(current_user) if signed_in?
  end

  def create
  	if required_params_present && create_user
      # if current_user_is_admin then redirect_to users_path
  		redirect_to user_todo_list_path(current_user)
  	else
      flash.now[:error] = "Login incorrect" if flash.now[:error].blank?
      render 'new'
	  end
	end

  def destroy
    sign_out
    redirect_to root_url
  end

  private

  def required_params_present
    errors = []
    missing_params = %i(email password).reject { |p| params[:session][p].present? }
    missing_params.each do |p|
      errors << "#{p.to_s} missing"
    end
    flash.now[:error] = errors.join ", "
    missing_params.empty?
  end

  def create_user
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      true
    else
      false
    end
  end
end
