module Api
  module V1
    class QuestionsController < ApiController
      def create
        ApplicationMailer.email_question(
          current_user.email,
          params[:subject],
          params[:body]
        ).deliver_now
      end
    end
  end
end
