class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :tab

  validates :tab, :presence => true
  validates :title, :presence => true
  validates :summary, :presence => true
  validates :content, :presence => true

  before_save :set_defaults

  private
  def set_defaults
    file_name = self.tab.name.downcase + '_' + Time.now.to_f.to_s + '.txt'
    directory = '/home/srspal/srspal.com/current/public/data/posts/'
    File.atomic_write(directory + file_name) do |file|
      file.write(self.content)
    end

    self.content = directory + file_name
  end
end

