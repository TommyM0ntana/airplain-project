module Api
  module V1
    class AirplainsController < ApplicationController
      skip_before_action :verify_authenticity_token

      # GET /api/v1/airplains
      def index
        airplains = Airplain.all
        render json: airplains
      rescue StandardError
        render json: { message: 'Something went wrong' }
      end

      # GET /api/v1/airplains/:id
      def show
        airplain = Airplain.find(params[:id])
        render json: airplain if airplain
      rescue StandardError => e
        render json: { messages: e.message }, status: :unprocessable_entity
      end

      # GET /api/v1/airplains
      def create
        airplain = Airplain.new(airplain_params)
        if airplain.save
          render json: airplain
        else
          render json: { message: 'Something went wront on save' }, status: :unprocessable_entity
        end
      rescue StandardError => e
        render json: { messages: e.message }, status: :unprocessable_entity
      end

      # GET /api/v1/airplains/:id
      def update
        airplain = Airplain.find(params[:id])
        if airplain.update(airplain_params)
          render json: { message: 'This airplain was successfully updated', airplain: airplain }
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { messages: e.message }, status: :unprocessable_entity
      end

      # GET /api/v1/airplains/:id
      def destroy
        airplain = Airplain.find(params[:id])
        if airplain.destroy
          render json: { message: 'This airplain was destroyed successfully' }
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { messages: e.message }, status: :unprocessable_entity
      end

      private

      def airplain_params
        params.require(:airplain).permit(:model, :first_class, :economic_class, :executive_class)
      end
    end
  end
end
