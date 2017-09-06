class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAILER_SENDER') { 'info@idleherder.com' }
  layout 'mailer'
end
