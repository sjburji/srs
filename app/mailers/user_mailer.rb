class UserMailer < ActionMailer::Base
  default :from => "mc@srspal.com"
  default :reply_to => "mc@srspal.com"
  default :template_path => "mailers"

  def password_reset(user)
    @user = user
    mail :to => user.email, 
      :subject => "srspal.com - Password Reset Instructions"
  end
end
