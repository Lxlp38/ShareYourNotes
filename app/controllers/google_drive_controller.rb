class GoogleDriveController < ApplicationController
  def select_file
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
  end

  def upload
    uploaded_io = params[:file]
    #return render plain: 'Invalid file', status: :unprocessable_entity unless uploaded_io.content_type.start_with?('image/') # Example validation

    file_path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(file_path, 'wb') do |file|
      file.write(uploaded_io.read)
    end
    #render plain: 'File uploaded successfully', status: :ok
  end
  #   return redirect_to '/auth/google_oauth2' unless session[:credentials]

  #   client = Google::Apis::DriveV3::DriveService.new
  #   client.authorization = Signet::OAuth2::Client.new(
  #     client_id: ENV['GOOGLE_CLIENT_ID'],
  #     client_secret: ENV['GOOGLE_CLIENT_SECRET'],
  #     token_credential_uri: 'https://accounts.google.com/o/oauth2/token'
  #   )
  #   client.authorization.update!(session[:credentials])

  #   file_metadata = {
  #     name: 'Test Document',
  #     mime_type: 'application/vnd.google-apps.document'
  #   }

  #   file = client.create_file(file_metadata, fields: 'id')
  #   redirect_to root_path, notice: "File created with ID: #{file.id}"
  # end
end
