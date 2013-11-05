class ListItem < ActiveRecord::Base
	mount_uploader :file, FileUploader

  belongs_to :user

  validates_presence_of :title, :user_id
	validates :url, 				length: { maximum: 500 }
	validates :title, 			length: { maximum: 500 }, presence: true

	default_scope -> { order('created_at DESC') }

	acts_as_list scope: :user
end
