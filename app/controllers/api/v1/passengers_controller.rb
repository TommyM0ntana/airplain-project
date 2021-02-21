module Api
  module V1
    class PassengersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        begin
          passengers = Passenger.all
          render json: passengers
        rescue StandardError => e
          render json: { message: "Something went wrong" } 
        end
      end

      def show
        begin
          passenger = Passenger.find(params[:id])
          if passenger
            render json: passenger
          end
        rescue StandardError => e
          render json: { messages: e.message }
        end
      end
     
      def create
        begin
          passenger = Passenger.new(passenger_params)
          if passenger.save
            render json: passenger
          else
            render json: { message: passenger.errors.messages }, status: :unprocessable_entity
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      def update
        begin
        passenger = Passenger.find(params[:id])
          if passenger.update(passenger_params)
            render json: { message: 'This Passenger was successfully updated', passenger: passenger }
          else
            render json: { message: 'Something went wront'}, status: 500
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      def destroy
        begin
          passenger = Passenger.find(params[:id])
          if passenger.destroy
            render json: 'This flight was successfully deleted'
          else
            render json: { message: 'Something went wront'}, status: 500
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      private

      def passenger_params
        params.require(:passenger).permit(:user_id, :flight_id, :email, :national_id, :telephone_number, :full_name)
      end

    end
  end
end