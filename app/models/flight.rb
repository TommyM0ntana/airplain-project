class Flight < ApplicationRecord
  belongs_to :airplain
  has_many :seats, dependent: :destroy
  has_many :passengers, dependent: :nullify
  has_many :flight_execution, dependent: :destroy

  validates :airplain_id, presence: true
  validates :origin, :destination, :duration, :time, :date, presence: true
  validate :minimum_duration
  validate :date_validity

  private

  def self.create_with_seats_and_execution(flight_params)
    new_flight = new(flight_params)
    if new_flight.save
      flight_execution = new_flight.flight_execution.build
      Seat.create_airplain_seats(flight_params[:airplain_id], new_flight) if flight_execution.save
      new_flight
    else
      { errors: new_flight.errors.messages }
    end
  end

  def date_validity
    errors.add(:date, "can't be before today") if date && (date < Date.today)
  end

  def minimum_duration
    errors.add(:duration, "can't be less than 30 min") if duration && (duration < 30)
  end
end
