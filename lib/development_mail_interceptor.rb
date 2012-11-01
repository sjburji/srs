class DevelopmentMailInterceptor
  def self.delivering_email(message)
  	message.subject = "#{message.to} #{message.subject} - #{message.cc}"
    message.to = ["suppijb@gmail.com"]
    message.cc = ""
    message.bcc = ""
  end
end