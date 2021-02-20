class Flight < ApplicationRecord
  belongs_to :airplain
  has_many :seats, dependent: :destroy
  has_many :passengers, dependent: :nullify
  has_one :flight_execution
end