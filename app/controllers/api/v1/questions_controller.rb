module Api
  module V1
    class QuestionsController < ApiController
      def create
        QuestionMailer.email_question(
          current_user.email,
          params[:subject],
          params[:body]
        ).deliver_later
      end
    end
  end
end
