require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class GoogleDriveController < ApplicationController
  before_action :authenticate_user!

  # Costanti per l'autenticazione OAuth
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
  APPLICATION_NAME = 'ShareYourNotes'.freeze
  CREDENTIALS_PATH = Rails.root.join('config/credentials.json')
  TOKEN_PATH = Rails.root.join('token.yaml')
  SCOPE = [
    'https://www.googleapis.com/auth/drive.file'
  ]

  def upload
    file_id = params[:file_id]

    drive_service = Google::Apis::DriveV3::DriveService.new
    drive_service.client_options.application_name = APPLICATION_NAME
    drive_service.authorization = authorize

    begin
      file_metadata = drive_service.get_file(file_id, fields: 'id, name, mime_type')
      file = drive_service.get_file(file_id, download_dest: StringIO.new)
    rescue Google::Apis::AuthorizationError => e
      render json: { error: 'Authorization error: Check the access token and its permissions.' }, status: :unauthorized
      return
    rescue Google::Apis::ClientError => e
      if e.status_code == 404
        render json: { error: 'File not found' }, status: :not_found
      else
        render json: { error: e.message }, status: :unprocessable_entity
      end
      return
    end
    
    file_path = Rails.root.join('public', 'uploads', file_metadata.name)
    File.open(file_path, 'wb') do |f|
      f.write(file.string)
    end

    @note = current_user.notes.new(title: file_metadata.name, pdf: file_path.to_s)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'File was successfully uploaded.' }
        format.json { render json: { message: 'File was successfully uploaded.', file: file_metadata } }
      else
        format.html { render :new }
        format.json { render json: { errors: @note.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end
  def authorize
    client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    user_id = current_user.id.to_s

    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts "Open the following URL in the browser and enter the resulting code after authorization:\n" + url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(user_id: user_id, code: code, base_url: OOB_URI)
    end
    credentials
  end
end
