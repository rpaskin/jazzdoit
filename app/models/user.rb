class User < ActiveRecord::Base
  validates :password, length: { minimum: 6 }
  validates :password_digest, presence: true
  validates :email, presence: true, email: true, uniqueness: true

  has_secure_password

  has_many :list_items

  before_save { self.email = email.downcase }

  private

  def invalid_list_item(item)
    item[:description].blank?
  end
end
