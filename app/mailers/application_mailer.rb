class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def email_question(from_email, subject, question_body)
    @from = from_email
    @subject = subject
    @question_body = question_body
    mail(to: @from, subject: @subject)
  end
end
