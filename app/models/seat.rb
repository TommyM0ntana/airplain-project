class Seat < ApplicationRecord
  belongs_to :flight
  belongs_to :passenger
  validates :flight_id, presence: true
  validates :passenger_id, presence: true
  
end
