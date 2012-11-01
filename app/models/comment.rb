class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :post_id, :presence => true, :numericality => true
  validates :user_id, :presence => true, :numericality => true
  validates :content, :presence => true, :length => { :minimum => 2, :maximum => 140 }

  after_save :send_mailer

  def send_mailer
  	PostMailer.comment_notification(self.id).deliver
  end
end
