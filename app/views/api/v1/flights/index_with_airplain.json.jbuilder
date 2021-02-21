json.array! @flights do |flight|
  json.id flight.id
  json.origin flight.origin
  json.duration flight.duration
  json.time flight.time
  json.destination flight.destination 
  json.airplain flight.airplain
  json.date flight.date
end
