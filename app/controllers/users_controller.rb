class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def signup_new
    @form_post_url = signup_users_path
    self.new
  end

  def edit
  end

  def create(form_path='new', next_path=nil)
    @user = User.new(user_params)
    next_path = @user unless next_path.present?

    respond_to do |format|
      if @user.save
        format.html { redirect_to next_path, notice: 'User was successfully created.' }
        format.json { render action: action, status: :created, location: @user }
      else
        format.html { render action: form_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def signup_create
    self.create("signup_new", nil)
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
