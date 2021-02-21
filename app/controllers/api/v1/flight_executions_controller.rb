module Api
  module V1
    class FlightExecutionsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        begin
          flight_executions = FlightExecution.all
          render json: flight_executions
        rescue StandardError => e
          render json: { message: "Something went wrong" } 
        end
      end

      def show
        begin
          flight_execution = FlightExecution.find(params[:id])
          if flight_execution
            render json: flight_execution
          end
        rescue StandardError => e
          render json: { messages: e.message }
        end
      end
      
      def create
        begin
          flight_execution = FlightExecution.new(flight_executions_params)
          if flight_execution.save
            render json: flight_execution
          else
            render json: { message: 'Something went wront on save'}, status: :unprocessable_entity
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      def update
        begin
          flight_execution = FlightExecution.find(params[:id])
          if flight_execution.update(flight_executions_params)
            render json: { message: 'This flight execution was successfully updated', flight_execution: flight_execution }
          else
            render json: { message: 'Something went wront'}, status: 500
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      def destroy
        begin
          flight_executions = FlightExecution.find(params[:id])
          if flight_executions.destroy
            render json: 'This flight was successfully deleted'
          else
            render json: { message: 'Something went wront'}, status: 500
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      private

      def flight_executions_params
        params.require(:flight_execution).permit(:flight_id, :status, :delayed, :canceled, :departure, :destination)
      end

    end
  end
end