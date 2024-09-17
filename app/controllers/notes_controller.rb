class NotesController < ApplicationController
  before_action :authenticate_user!, only: %i[suspended_notes]
  before_action :set_note, only: %i[ show edit admin_edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :index_favorites]

  # GET /notes or /notes.json
  def index
    if params[:notes_per_page].nil?
      params[:notes_per_page] = 20
    end

    if params[:page_index].nil?
      params[:page_index] = 1
    end

    notes_per_page = params[:notes_per_page].to_i
    page_index = params[:page_index].to_i
    @notes = Note.where(visibility: true, suspended: false)

    if params[:filter].present?
      if params[:filter].include?("#")
        @parameter = params[:filter].gsub(/[^0-9A-Za-z]/, '').downcase
        @tag = Tag.find_by("lower(name) LIKE ?", "%#{@parameter}%")
        @notes = @tag.notes.where(visibility: true, suspended: false).limit(notes_per_page).offset(notes_per_page * (page_index-1))  if @tag
      else
        @notes = @notes.where("lower(title) LIKE ?", "%#{params[:filter].downcase}%").limit(notes_per_page).offset(notes_per_page * (page_index-1))
      end
    end

    if !current_user.nil?
      if params[:filter_university] == "true"
        @notes = @notes.where(university_id: current_user.university_details_id)
      end
    end

    @notes = ordinamento(@notes)

    @notes = @notes.each_slice(notes_per_page).to_a[page_index-1]
  end

  def index_favorites
    @favorites = Favorite.where(:user_id => params[:user_id], :favorite => true).pluck(:note_id)
    @notes = Note.where(visibility: true, suspended: false).find(@favorites)
  end

  # GET /notes
  def suspended_notes
    @notes = Note.where(suspended: true)
  end

  # GET /notes/1 or /notes/1.json
  def show
    @note = Note.find(params[:id])
    @reviews = @note.reviews
  end

  # GET /notes/new
  def new
    @note = Note.new
    @universities = University.all
    @courses = Course.where(university_id: @note.university_id)
    #variabile usata in create per aggiungere i tag
    @tag_names = ''
    authorize! :new, @note, :message => "Not authorized as an administrator."
  end



  def courses_by_university
    @courses = Course.where(university_id: params[:university_id])
    render json: @courses
  end


  # GET /notes/1/edit
  def edit
    @courses = Course.all
    @universities = University.all
  end

  # GET /notes/1/admin_edit
  def admin_edit
    @courses = Course.all
    @universities = University.all
  end

  def toggle_favorite
    @user_id = params[:user_id]
    @note_id = params[:note_id]
    @favorite = Favorite.find_by(user_id: @user_id, note_id: @note_id)
    if @favorite.nil?
      # Add new favorite entry
      @favorite = Favorite.create(user_id: @user_id, note_id: @note_id, favorite: true)
    else
      # Toggle between favorite/non favorite
      @favorite.update(favorite: !@favorite.favorite)
    end

    respond_to do |format|
      if @favorite.favorite
        format.html { redirect_to request.referrer, notice: "Note was added to favorites!" }
      else
        format.html { redirect_to request.referrer, alert: "Note was removed from favorites!" }
      end
    end
  end

  # POST /notes or /notes.json
  def create
    #ho usato tag_name perchè con tag e tags poteva creare ambiguità
    @note = Note.new(note_params)
    @note.owner_id = current_user.id
    tag_names = params[:note][:tag_names].split(",").map(&:strip)

    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      @note.tags << tag unless @note.tags.include?(tag) # << operatore che aggiunge tag alla collezione @note.tags
    end

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
    @note.tags.destroy_all
    tag_names = params[:note][:tag_names].split(",").map(&:strip)
    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      @note.tags << tag unless @note.tags.include?(tag) # << operatore che aggiunge tag alla collezione @note.tags
    end

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
    Favorite.where(:note_id => @note).destroy_all #important due to foreign key constraints
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def ordinamento(notes)
    case params[:sort_by]
    when "title_asc"
      notes.order("LOWER(title) ASC")
    when "title_desc"
      notes.order("LOWER(title) DESC")
    when "created_at_asc"
      notes.order("created_at ASC")
    when "created_at_desc"
      notes.order("created_at DESC")
    else
      notes.order("created_at ASC")
    end

  end
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :owner_id, :course_id, :university_id, { pdf: [] }, :visibility, :suspended, :filter, :page_index, :notes_per_page, tag_ids:[])
    end
end
