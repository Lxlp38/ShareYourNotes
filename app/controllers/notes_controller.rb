class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /notes or /notes.json
  def index
    @notes = Note.where(visibility: true)
  end

  # GET /notes/1 or /notes/1.json
  def show
    @note = Note.find(params[:id])
    @reviews = @note.reviews
  end

  # GET /notes/new
  def new
    @note = Note.new
    @courses = Course.all
    authorize! :new, @note, :message => "Not authorized as an administrator."
    

  end

  # GET /notes/1/edit
  def edit
    @courses = Course.all
  end

  # POST /notes or /notes.json
  def create

    @note = Note.new(note_params)
    @note.owner_id = current_user.id

    respond_to do |format|
      if @note.save
        format.html { redirect_to note_url(@note), notice: "Note was successfully created." }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to note_url(@note), notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :owner_id, :course_id, { pdf: [] }, :visibility)
    end
end
