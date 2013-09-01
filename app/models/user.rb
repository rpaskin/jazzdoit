class User < ActiveRecord::Base
  validates :password, length: { minimum: 6 }
  validates :password_digest, presence: true
  validates :email, presence: true, email: true, uniqueness: true

  has_many :list_items

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  has_secure_password

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt_token(token)
    Digest::SHA1.hexdigest(token)
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt_token(User.new_token)
    end
end
