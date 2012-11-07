class UploadController < ApplicationController
  def upload_file
    if signed_in? and author_signed_in?
    	if Rails.env == 'production'
    		file_path = Settings.deploy_path + '/data/images'
    	else
    		file_path = 'public/data/images'
    	end
      DataFile.save(params[:upload], file_path)
      redirect_to(upload_path, :notice => 'File upload was successful')
    else
      redirect_to(root_path, :alert => 'File upload not allowed, Please sign-in and try again')
    end
  end

  def upload_image
    if signed_in?
      upload = params[:upload]
      user_id = current_user.id
      if Rails.env == 'production'
    		path = Settings.deploy_path + '/profiles'
    	else
    		path = 'public/images/profiles'
    	end
    	filename_extension = File.extname(upload[:datafile].original_filename)
      DataFile.save(upload, path, user_id.to_s + filename_extension)
      user = User.find(user_id)
      directory_path = Settings.site_url + '/images/profiles/' + user_id.to_s + filename_extension
      user.image = directory_path
      user.save(:validate => false)

      redirect_to(user_path(user), :notice => 'Image upload was successful, Please wait for some time to refresh')
    else
      redirect_to(root_path, :alert => 'Image upload not allowed, Please sign-in and try again')
    end
  end

  def upload
    if signed_in? and author_signed_in?
      @title = 'UPLOAD'
      if Rails.env == 'production'
        @file_path = Settings.deploy_path + "/data/images"
      else
        @file_path = "public/data/images"
      end
    else
      redirect_to(root_path, :alert => 'Upload not allowed, Please sign-in and try again')
    end
  end

  def image_upload
    if signed_in?
      @title = 'IMAGE UPLOAD'
    else
      redirect_to(root_path, :alert => 'Image upload not allowed, Please sign-in and try again')
    end
  end
end
        
