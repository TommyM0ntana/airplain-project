module Api
  module V1
    class SeatsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        begin
          seats = Seat.all
          seats = seats.where(flight_id: params[:flight_id]) if params[:flight_id]
          render json: seats
        rescue StandardError => e
          render json: { message: "Something went wrong" } 
        end
      end

      def show
        begin
          seat = Seat.find(params[:id])
          if seat
            render json: seat
          end
        rescue StandardError => e
          render json: { messages: e.message }
        end
      end
     
      def create
        begin
          flight = Flight.find(params[:flight_id])
          seat = Seat.create_airplain_seats(flight.airplain_id, flight)
          if seat
            render json: seat
          else
            render json: { message: 'Something went wront on save'}, status: :unprocessable_entity
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      def update
        begin
        seat = Seat.find(params[:id])
          if seat.update(seat_params)
            render json: { message: 'This seat was successfully updated', seat: seat }
          else
            render json: { message: 'Something went wront'}, status: 500
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      def destroy
        begin
          seat = Seat.find(params[:id])
          if seat.destroy
            render json: 'This seat was successfully deleted'
          else
            render json: { message: 'Something went wront'}, status: 500
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      private

      def seat_params
        params.require(:seat).permit(:flight_id, :passenger_id, :seat_class, :near_exit, :extra_leg_space, :window_seat)
      end

    end
  end
end