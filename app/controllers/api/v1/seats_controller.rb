module Api
  module V1
    class SeatsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        @seats = Seat.all
        @seats = seats.where(flight_id: params[:flight_id]) if params[:flight_id]
        render 'seats'
      rescue StandardError
        render json: { message: 'Something went wrong' }
      end

      def show
        @seat = Seat.find(params[:id])
        render 'seat' if @seat
      rescue StandardError => e
        render json: { messages: e.message }
      end

      def create
        flight = Flight.find(params[:flight_id])
        seat = Seat.create_airplain_seats(flight.airplain_id, flight)
        if seat
          render json: seat
        else
          render json: { message: 'Something went wront on save' }, status: :unprocessable_entity
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def update
        seat = Seat.find(params[:id])
        if seat.update(seat_params)
          render json: { message: 'This seat was successfully updated', seat: seat }
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def destroy
        seat = Seat.find(params[:id])
        if seat.destroy
          render json: 'This seat was successfully deleted'
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      private

      def seat_params
        params.require(:seat).permit(:flight_id, :passenger_id, :seat_class, :near_exit, :extra_leg_space, :window_seat)
      end
    end
  end
end
