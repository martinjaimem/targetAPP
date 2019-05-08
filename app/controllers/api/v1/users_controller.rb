# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      helper_method :user
      before_action :user, only: %i[show update destroy]
      skip_before_action :verify_authenticity_token, only: %i[index show create]

      def index
        @users = User.all
        render json: @users
      end

      def show; end

      def create
        @user = User.new(user_params)
        if @user.save
          render :show
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        @user.update!(user_params)
        render :show
      end

      def destroy
        @user.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def user
        @user = User.find(params[:id])
      end

      # Only allow a trusted parameter 'white list' through.
      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :username, :gender)
      end
    end
  end
end
