module Api
  module V1
    class PassengersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        @passengers = Passenger.all
        @passengers = @passengers.where(user_id: params[:user_id]) if params[:user_id]
        render 'passengers'
      rescue StandardError
        render json: { message: 'Something went wrong' }
      end

      def show
        @passenger = Passenger.find(params[:id])
        render 'show' if @passenger
      rescue StandardError => e
        render json: { messages: e.message }
      end

      def create
        passenger = Passenger.new(passenger_params)
        if passenger.save
          render json: passenger
        else
          render json: { message: passenger.errors.messages }, status: :unprocessable_entity
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def book_flight_seat
        passenger = Passenger.find(params[:id])
        seat = Seat.find(params[:seat_id])
        if seat.update(passenger_id: passenger.id)
          render json: seat
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def update
        passenger = Passenger.find(params[:id])
        if passenger.update(passenger_params)
          render json: { message: 'This Passenger was successfully updated', passenger: passenger }
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def destroy
        passenger = Passenger.find(params[:id])
        if passenger.destroy
          render json: 'This passenger was successfully deleted'
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      private

      def passenger_params
        params.require(:passenger).permit(:user_id, :flight_id, :email, :national_id, :telephone_number, :full_name)
      end
    end
  end
end
