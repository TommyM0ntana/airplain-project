Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :airplains
      resources :flights
      resources :flight_executions
      resources :seats
      resources :passengers
      resources :users
      put 'passengers/:id/book_flight_seat/:seat_id', to: 'passengers#book_flight_seat', as: 'book_flight_seat'
    end
  end

end
