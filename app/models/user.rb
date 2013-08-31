class User < ActiveRecord::Base
  validates :password, length: { minimum: 6 }
  validates :password_digest, presence: true
  validates :email, presence: true, email: true, uniqueness: true

  has_many :list_items

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  has_secure_password

  private
    def create_remember_token
      self.remember_token = Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64)
    end
end
