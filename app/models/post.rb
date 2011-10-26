class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :tab

  before_save :set_defaults

  private
  def set_defaults
    file_name = self.tab.name.downcase + '_' + Time.now.to_f.to_s + '.txt'
    directory = 'public/data/posts/'
    File.atomic_write(directory + file_name) do |file|
      file.write(self.content)
    end

    self.content = directory + file_name
  end
end
