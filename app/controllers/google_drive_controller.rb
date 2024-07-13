require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
class GoogleDriveController < ApplicationController
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
    APPLICATION_NAME = 'Google Drive API Ruby Quickstart'
    CREDENTIALS_PATH = 'token.yaml'
    SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_FILE
  
    def authorize
      client_id = ENV['GOOGLE_KEY']
      client_secret = ENV['GOOGLE_SECRET']
      client = Signet::OAuth2::Client.new(
        client_id: client_id,
        client_secret: client_secret,
        authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
        token_credential_uri: 'https://oauth2.googleapis.com/token',
        redirect_uri: 'http://localhost:3000/auth/google_oauth2/callback',
        scope: SCOPE
      )
      redirect_to client.authorization_uri.to_s
    end
  
    def callback
      client_id = ENV['GOOGLE_KEY']
      client_secret = ENV['GOOGLE_SECRET']
      client = Signet::OAuth2::Client.new(
        client_id: client_id,
        client_secret: client_secret,
        token_credential_uri: 'https://oauth2.googleapis.com/token',
        redirect_uri: 'http://localhost:3000/auth/google_oauth2/callback',
        scope: SCOPE
      )
      client.code = params[:code]
      response = client.fetch_access_token!
      session[:google_drive_token] = response['access_token']
  
      redirect_to new_note_path, notice: "Google Drive authorized successfully!"
    end
  
    def upload
      # Implementa il codice per caricare i file su Google Drive
    end
  end