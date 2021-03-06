class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, except: [:signup_new, :signup_create, :todo_list, :login, :destroy_done_items]
  before_action :verify_user, only: [:todo_list, :destroy_done_items]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @list_items = @user.list_items #.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def signup_new
    redirect_to user_todo_list_path(current_user) if signed_in?
    @form_post_url = signup_users_path
    self.new
  end

  def edit
    @button_label = "Update User"
  end

  def create(form_path='new', next_path=nil)
    @user = User.new(user_params)
    next_path = @user unless next_path.present?
    @button_label = "Create User"

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to next_path, notice: 'User was successfully created.' }
      else
        format.html { render action: form_path }
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
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

  def todo_list
    @user = User.find(params[:id])
    @list_items = @user.list_items.order(:position)
    @list_item = @user.list_items.build
  end

  def destroy_done_items
    message = current_user.done_items.delete_all ? 'Deleted done items.' : 'Error deleting.'

    respond_to do |format|
      format.html { redirect_to current_user, notice: message }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def admin_only
      redirect_to signup_users_path unless current_user_is_admin
    end

    def verify_user
      redirect_to user_todo_list_path(current_user) unless (current_user.id == params[:id].to_i)
    end
end
