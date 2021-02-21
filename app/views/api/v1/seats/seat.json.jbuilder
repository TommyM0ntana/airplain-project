json.id @seat.id
json.seat_class @seat.seat_class
json.near_exit @seat.near_exit
json.extra_leg_space @seat.extra_leg_space
json.window_seat @seat.window_seat
json.flight @seat.flight
json.is_empty @seat.passenger.nil?
