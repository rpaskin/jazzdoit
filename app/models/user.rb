class User < ActiveRecord::Base
  validates :password, presence: true
  validates :email, presence: true, email: true, uniqueness: true
end
