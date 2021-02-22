module Api
  module V1
    class FlightExecutionsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        flight_executions = FlightExecution.all
        render json: flight_executions
      rescue StandardError
        render json: { message: 'Something went wrong' }
      end

      def show
        flight_execution = FlightExecution.find(params[:id])
        render json: flight_execution if flight_execution
      rescue StandardError => e
        render json: { messages: e.message }
      end

      def create
        flight_execution = FlightExecution.new(flight_executions_params)
        if flight_execution.save
          render json: flight_execution
        else
          render json: { message: 'Something went wront on save' }, status: :unprocessable_entity
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def update
        flight_execution = FlightExecution.find(params[:id])
        if flight_execution.update(flight_executions_params)
          render json: { message: 'This flight execution was successfully updated', flight_execution: flight_execution }
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def destroy
        flight_executions = FlightExecution.find(params[:id])
        if flight_executions.destroy
          render json: 'This flight execution was successfully deleted'
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      private

      def flight_executions_params
        params.require(:flight_execution).permit(:flight_id, :status, :delayed, :canceled, :departure, :destination)
      end
    end
  end
end
