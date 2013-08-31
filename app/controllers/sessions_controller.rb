class SessionsController < ApplicationController
  def new
  end

  def create
  	if ok_to_create_user
  		create_user
  		# redirect to list
  	else
      render 'new'
	  end
	end

  def destroy
  end

  private

  def ok_to_create_user
		if User.find_by(email: params[:session][:email].downcase)
			flash[:error] = "Email already taken"
			false
		end
		true
  end

  def create_user
  end
end
