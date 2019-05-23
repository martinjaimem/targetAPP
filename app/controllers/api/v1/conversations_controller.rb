module Api
  module V1
    class ConversationsController < ApiController
      include Pagy::Backend

      def messages
        @pagy, @messages = pagy(conversation.messages)
      end

      def index
        conversations
      end

      private

      def conversation
        @conversation ||= current_user.conversations.find(params[:conversation_id])
      end

      def conversations
        @conversations = if conversation_params[:has_unread_messages]
                           current_user.conversations_with_unread_messages
                         else
                           current_user.conversations
                         end
      end

      def conversation_params
        params.permit(:has_unread_messages)
      end
    end
  end
end
