class ListItem < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :description, :user_id
	validates :description, length: { maximum: 500 }
	validates :url, 				length: { maximum: 500 }

	default_scope -> { order('created_at DESC') }
end
