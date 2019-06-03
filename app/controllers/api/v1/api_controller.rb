module Api
  module V1
    class ApiController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_user!, except: :status

      rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

      # GET /status
      def status
        render json: { online: true }
      end

      def render_record_invalid(exception)
        logger.info(exception)
        render(
          json: { errors: exception.record.errors.as_json },
          status: :bad_request
        )
      end
    end
  end
end
