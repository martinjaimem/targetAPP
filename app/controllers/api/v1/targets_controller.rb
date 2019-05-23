module Api
  module V1
    class TargetsController < ApiController
      before_action :authenticate_user!

      def index
        @targets = current_user.targets
      end

      def create
        @target = current_user.targets.create!(target_params)
        @conversations = @target.conversations_of_matched_targets
      end

      def destroy
        target.destroy!
      end

      private

      def target
        @target ||= current_user.targets.find(params[:id])
      end

      def target_params
        params.require(:target).permit(:lng, :last_name, :lat, :radius, :title, :topic_id)
      end
    end
  end
end
