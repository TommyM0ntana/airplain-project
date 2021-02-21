json.id @user.id
json.full_name @user.full_name
json.email @user.email
json.flights json.array @user.passengers do |passenger|
  json.flight passenger.flight
end