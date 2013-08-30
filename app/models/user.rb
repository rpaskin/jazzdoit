class User < ActiveRecord::Base
  validates :password, length: { minimum: 6 }
  validates :password_digest, presence: true
  validates :email, presence: true, email: true, uniqueness: true

  before_save { self.email = email.downcase }

  has_secure_password
end
