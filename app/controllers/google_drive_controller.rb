require 'google/apis/drive_v3'
require 'googleauth'

class GoogleDriveController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def upload
    file_id = params[:file_id]
    access_token = params[:access_token]

    drive_service = Google::Apis::DriveV3::DriveService.new
    drive_service.authorization = access_token

    file_metadata = drive_service.get_file(file_id, fields: 'id, name, mime_type')
    file = drive_service.get_file(file_id, download_dest: StringIO.new)
    
    file_path = Rails.root.join('public', 'uploads', file_metadata.name)
    File.open(file_path, 'wb') do |f|
      f.write(file.string)
    end

    @note = current_user.notes.new(title: file_metadata.name, pdf: file_path.to_s)

    if @note.save
      redirect_to @note, notice: 'File was successfully uploaded.'
    else
      render :new
    end
  end
end