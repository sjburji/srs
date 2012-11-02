ActionMailer::Base.smtp_settings = {
  :address              => "mail.srspal.com",
  :port                 => 587,
  :domain               => "srspal.com",
  :user_name            => "mc@srspal.com",
  :password             => "msrsas60",
  :authentication 			=> :login,
  :enable_starttls_auto => false
}

require 'development_mail_interceptor'
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
