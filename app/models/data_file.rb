class DataFile < ActiveRecord::Base
  def self.save(upload, directory_path, file_name = nil)
  	if file_name
  		name = file_name
  	else
  		name = upload['datafile'].original_filename
  	end
    directory = directory_path
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end
end

