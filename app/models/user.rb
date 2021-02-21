class User < ApplicationRecord
  has_many :passengers, dependent: :destroy
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6, maximum: 16 }, format: { with: /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$/, multiline: true }
  validates :full_name, length: { minimum: 5 }
end