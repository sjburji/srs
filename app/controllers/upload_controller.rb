class UploadController < ApplicationController
  def upload_file
    if signed_in? and author_signed_in?
      DataFile.save(params[:upload], 'data/images')
      redirect_to upload_path
    else
      redirect_to root_path
    end
  end

  def upload
    if signed_in? and author_signed_in?
      @title = 'UPLOAD'
    else
      redirect_to root_path
    end
  end
end