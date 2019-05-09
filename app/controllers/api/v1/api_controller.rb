module Api
  module V1
    class ApiController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_user!

      # GET /status
      def status
        render json: { online: true }
      end
    end
  end
end
