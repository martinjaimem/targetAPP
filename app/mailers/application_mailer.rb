class ApplicationMailer < ActionMailer::Base
  default to: 'admin@trgtapp.com'
  layout 'mailer'
end
