class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :tab

  validates :tab, :presence => true
  validates :title, :presence => true
  validates :content, :presence => true

  before_save :set_defaults
  after_create :send_mailer

  def send_mailer
    PostMailer.post_creation_notification(self.id).deliver    
  end

  private
  def set_defaults
    file_name = self.tab.name.downcase + '_' + Time.now.to_f.to_s + '.txt'
    if Rails.env == 'production'
      directory = Settings.deploy_path + '/data/posts/'
    else
      directory = 'public/data/posts/'
    end
    File.atomic_write(directory + file_name) do |file|
      file.write(self.content)
    end

    self.content = directory + file_name
  end
end

