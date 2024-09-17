require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class GoogleDriveController < ApplicationController
  before_action :authenticate_user!

  CREDENTIALS_PATH = Rails.root.join('config/credentials.json')

  def upload
    file_id = params[:file_id]
    file_name = params[:file_name]
    file_content = params[:file_content]

    file_path = Rails.root.join('public', 'uploads', file_name)
    File.open(file_path, 'wb') do |f|
      f.write(file_content.read)
    end



    # TODO: creare la nota e salvare quello che serve. Il file viene già caricato dal FE al BE, qui sopra c'è il fileId, fileName e il suo contenuto (salvato in upload)
    #@note = Note.new(title: file_name, university_id: :universityID, course_id: :courseID, owner_id: current_user.id, visibility: :visibilityParams, suspended: false)
    #@note.pdf = [File.open(file_path)]

    respond_to do |format|
      if true #@note.save
        File.delete(file_path) if File.exist?(file_path)

        #format.html { redirect_to note_url(@note), notice: 'File was successfully uploaded.' }
        format.json { render json: { message: 'File was successfully uploaded.', file: file_name } }
      else
        format.html { render :new }
        format.json { render json: { errors: @note.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

end
