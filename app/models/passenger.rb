class Passenger < ApplicationRecord
  belongs_to :user
  belongs_to :flight
  has_many :seats, dependent: :nullify
end
