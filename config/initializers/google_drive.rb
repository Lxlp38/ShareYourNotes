require 'google_drive'

Google::Apis::ClientOptions.default.application_name = 'ShareYourNotes'
Google::Apis::ClientOptions.default.application_version = '0.0.1'

config = JSON.parse(File.read(Rails.root.join('config/credentials.json')))
$google_drive_credentials = Google::Auth::UserRefreshCredentials.new(
  client_id: config["web"]["client_id"],
  client_secret: config["web"]["client_secret"],
  scope: [
    'https://www.googleapis.com/auth/drive',
    'https://www.googleapis.com/auth/drive.file'
  ],
  redirect_uri: config["web"]["redirect_uris"].first
)

auth_url = $google_drive_credentials.authorization_uri
