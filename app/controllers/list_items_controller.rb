class ListItemsController < ApplicationController
  before_action :signed_in_user
	before_action :correct_user_for_item,   only: :destroy
  before_action :set_list_item, only: [:update, :move_lower, :move_higher]

  def index
  end

  def create
		@list_item = current_user.list_items.build(list_item_params)
    unless @list_item.save
	  	flash[:error] = "Unable to create"
    end
    redirect_to user_todo_list_path(current_user)
  end

  def destroy
	  @list_item.destroy
    redirect_to user_todo_list_path(current_user)
  end

  def update
    if (params[:list_item][:file] rescue nil)
      @list_item.file = params[:list_item][:file]
      @list_item.save
    end
    if (params[:list_item][:description] rescue nil)
      @list_item.description = params[:list_item][:description]
      @list_item.save
    end
	  if (params[:list_item][:percent_done] rescue nil)
		  @list_item.percent_done = params[:list_item][:percent_done].to_i
      @list_item.percent_updated_at = DateTime.now
      @list_item.save
		end
    redirect_to user_todo_list_path(current_user)
  end

  def move_lower
    @list_item.move_lower
    redirect_to user_todo_list_path(current_user)
  end

  def move_higher
    @list_item.move_higher
    redirect_to user_todo_list_path(current_user)
  end

	private

    def list_item_params
      params.require(:list_item).permit(:title, :file, :description, :percent_done)
    end

		def correct_user_for_item
      @list_item = current_user.list_items.find_by(id: params[:id])
      redirect_to user_todo_list(current_user) if @list_item.nil?
    end

    def set_list_item
      @list_item = current_user.list_items.find_by(id: params[:id])
    end
end
