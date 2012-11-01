class PostMailer < ActionMailer::Base
	default :from => "mc@srspal.com"
  default :reply_to => "mc@srspal.com"
  default :template_path => "mailers"

  def post_creation_notification(post_id)
    @post = Post.find_by_id(post_id)
    mail(:to => Settings.mail_to_id,
      :subject => "srspal.com - New post created ...!")
  end

  def comment_notification(comment_id)
  	@comment = Comment.find_by_id(comment_id)
  	mail(:to => Settings.mail_to_id,
      :subject => "srspal.com - New Comment recorded ...!")
  end

  def user_subscription(user_id)
  	@user = User.find_by_id(user_id)
  	mail(:to => Settings.mail_to_id,
      :subject => "srspal.com - New User Signed up ...!")
  end
end