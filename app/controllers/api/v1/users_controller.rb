module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        users = User.all
        render json: users
      rescue StandardError
        render json: { message: 'Something went wrong' }
      end

      def show
        @user = User.find(params[:id])
        render 'user' if @user
      rescue StandardError => e
        render json: { messages: e.message }
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user
        else
          render json: { message: user.errors.messages }, status: :unprocessable_entity
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def update
        user = User.find(params[:id])
        if user.update(user_params)
          render json: 'This user was successfully updated'
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      def destroy
        user = User.find(params[:id])
        if user.destroy
          render json: 'This user was successfully deleted'
        else
          render json: { message: 'Something went wront' }, status: 500
        end
      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      end

      private

      def user_params
        params.require(:user).permit(:password, :email, :full_name)
      end
    end
  end
end
