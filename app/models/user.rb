class User < ApplicationRecord
  has_secure_password

  validates :full_name, presence: true, length: { minimum: 2, maximum: 50 }

  validates :password, presence: true, length: { minimum: 6, maximum: 12 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  before_save { email.downcase! }

  has_many :purchases, dependent: :destroy
  has_many :access_tokens, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id, dependent: :destroy
end
