class ListItem < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :description, :user_id
	validates :description, presence: true
	validates :url, 				length: { maximum: 500 }

	default_scope -> { order('created_at DESC') }

	acts_as_list scope: :user
end
