module Api
  module V1
    class MessagesController < ApiController
      include Pagy::Backend

      def index
        @pagy, @messages = pagy(conversation.messages.reverse_order)
        ReadMessagesJob.perform_later(conversation, current_user)
      end

      private

      def conversation
        @conversation ||= current_user.conversations.find(params[:conversation_id])
      end
    end
  end
end
