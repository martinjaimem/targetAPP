class QuestionMailer < ApplicationMailer
  def email_question(from_email, subject, question_body)
    @from = from_email
    @subject = subject
    @question_body = question_body
    mail(from: @from, subject: @subject, template_name: 'email_question')
  end
end
