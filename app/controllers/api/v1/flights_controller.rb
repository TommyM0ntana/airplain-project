module Api
  module V1
    class FlightsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        begin
          @flights = Flight.all
          render 'index_with_airplain'
        rescue StandardError => e
          render json: { message: "Something went wrong" } 
        end
      end

      def show
        begin
          flight = Flight.find(params[:id])
          if flight
            render json: flight
          end
        rescue StandardError => e
          render json: { messages: e.message }
        end
      end

      def create
        begin
          flight = Flight.create_with_seats_and_execution(flight_params)
          unless flight.errors
            render json: flight
          else
            render json: { message: flight }, status: :unprocessable_entity
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      def update
        begin
          flight = Flight.find(params[:id])
          if flight.update(flight_params)
            render json: { message: 'This flight was successfully updated', flight: flight }
          else
            render json: { message: 'Something went wront'}, status: 500
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      def destroy
        begin
          flight = Flight.find(params[:id])
          if flight.destroy
            render json: 'This flight was successfully deleted'
          else
            render json: { message: 'Something went wront'}, status: 500
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      private

      def flight_params
        params.require(:flight).permit(:airplain_id, :origin, :duration, :time, :date, :destination)
      end

    end
  end
end