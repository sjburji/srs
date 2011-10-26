class DataFile < ActiveRecord::Base
  def self.save(upload, directory_path)
    name =  upload['datafile'].original_filename
    directory = "public/" + directory_path
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end  
end