class FlightExecution < ApplicationRecord
  belongs_to :flight
  validates :flight_id, presence: true
  validates :departure, presence: true
  validates :status, presence: true
  enum status: %w[scheduled on_gate boarding last_call in_air landing arrived].index_by(&:itself), _prefix: :visibility
end