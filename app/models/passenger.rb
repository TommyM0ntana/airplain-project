class Passenger < ApplicationRecord
  belongs_to :user
  belongs_to :flight
  has_many :seats, dependent: :nullify
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :full_name, length: { minimum: 5 }
  validates :telephone_number, length: { minimum: 9, maximum: 10 }, format: { with: /\A\d+\Z/ }
  validates_length_of :national_id, is: 16, uniqueness: true
  validates :national_id, presence: true
end
