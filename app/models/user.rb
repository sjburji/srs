class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :name, :image
  has_secure_password
  validates_presence_of :password, :on => :create
  before_create { generate_token(:auth_token) }

  belongs_to :role
  
  validates :name, :presence => true, :length   => { :maximum => 30 }
  validates :email, :email => true, :presence => true,
    :length => { :maximum => 50 }, :uniqueness => true
  validates :role_id, :presence => true, :numericality => true
  
  before_validation :set_defaults
  after_create :send_mailer
  before_create { generate_token(:auth_token) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_mailer
    PostMailer.user_subscription(self.id).deliver
  end

  private
  def set_defaults
    if self.role_id.nil?
      self.role_id = Role::SUBSCRIBER
    end
  end
end