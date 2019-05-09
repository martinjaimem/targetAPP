module Api
  module V1
    class TargetsController < ApplicationController
      before_action :authenticate_user!

      def index
        @targets = Target.where(user_id: current_user[:id])
      end

      def show
        target
      end

      def create
        @target = current_user.targets.create!(target_params)
      end

      delegate :destroy, to: :target

      private

      def target
        @target ||= Target.find(params[:id])
      end

      def target_params
        params.require(:target).permit(:lng, :last_name, :lat, :radius, :title, :topic_id)
      end
    end
  end
end
