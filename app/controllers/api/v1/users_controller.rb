module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        begin
          users = User.all
          render json: users
        rescue StandardError => e
          render json: { message: "Something went wrong" } 
        end
      end

      def show
        begin
          @user = User.find(params[:id])
          if @user
            render 'user'
          end
        rescue StandardError => e
          render json: { messages: e.message }
        end
      end
     
      def create
        begin
          user = User.new(user_params)
          if user.save
            render json: user
          else
            render json: { message: user.errors.messages }, status: :unprocessable_entity
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      def update
        begin
        user = User.find(params[:id])
          if user.update(user_params)
            render json: 'This user was successfully updated'
          else
            render json: { message: 'Something went wront'}, status: 500
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      def destroy
        begin
          user = User.find(params[:id])
          if user.destroy
            render json: 'This user was successfully deleted'
          else
            render json: { message: 'Something went wront'}, status: 500
          end
        rescue StandardError => e
          render json: { message: e.message }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:password, :email, :full_name)
      end

    end
  end
end