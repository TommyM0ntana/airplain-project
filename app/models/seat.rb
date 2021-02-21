class Seat < ApplicationRecord
  belongs_to :flight
  belongs_to :passenger, optional: true
  enum seat_class: %w[first_class executive_class economic_class].index_by(&:itself), _prefix: :visibility

  private

  def self.create_airplain_seats(airplain_id, new_flight)
    airplain = Airplain.find(airplain_id)
    first_class = airplain.first_class
    executive_class = airplain.executive_class
    economic_class = airplain.economic_class
    (0...first_class).each do |_n|
      new_flight.seats.build(seat_class: 'first_class').save
    end
    (0...executive_class).each do |_n|
      new_flight.seats.build(seat_class: 'executive_class').save
    end
    (0...economic_class).each do |_n|
      new_flight.seats.build(seat_class: 'economic_class').save
    end
    { message: 'Seats Created', seats: { first_class: first_class, executive_class: executive_class, economic_class: economic_class } }
  end
end
