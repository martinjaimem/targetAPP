class ApplicationMailer < ActionMailer::Base
  default to: 'admin@targetapp.com'
  layout 'mailer'
end
