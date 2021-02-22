module Api
  module V1
    class FlightsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        @flights = Flight.all
        @flights = @flights.where(destination: params[:destination]) if params[:destination]
        @flights = @flights.where(origin: params[:origin]) if params[:origin]
        @flights = @flights.where(date: params[:date]) if params[:date]
        @flights = @flights.order('date ASC')
        render 'index_with_airplain'
      rescue StandardError
        render json: { message: 'Something went wrong' }
      end

      def show
        flight = Flight.find(params[:id])
        render json: flight if flight
      rescue StandardError => e
        render json: { messages: e.message }
      end

      def create
        flight = Flight.create_with_seats_and_execution(flight_params)
        if flight.errors
          render json: { message: flight }, status: :unprocessable_entity
        else
          render json: flight
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def update
        flight = Flight.find(params[:id])
        if flight.update(flight_params)
          render json: { message: 'This flight was successfully updated', flight: flight }
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def destroy
        flight = Flight.find(params[:id])
        if flight.destroy
          render json: 'This flight was successfully deleted'
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      private

      def flight_params
        params.require(:flight).permit(:airplain_id, :origin, :duration, :time, :date, :destination)
      end
    end
  end
end
