class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  # this line goes next to the existing before_action statement
  before_action :has_user_and_note, :only => [:new, :create]



  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
    @note = Note.find(params[:note_id])

  end

  # GET /reviews/new
  def new
    @note = Note.find(params[:note_id])
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    @note = Note.find(params[:note_id])

  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)

    @note.reviews << @review
    current_user.reviews << @review  

    respond_to do |format|
      if @review.save
        format.html { redirect_to note_review_path(@note,@review), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to note_review_path(@note,@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to note_review_path, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:title, :rating, :text)
    end

# this code goes AT THE END of the file (but before the class ends...)
protected
def has_user_and_note
	if current_user.nil?
		flash[:warning] = 'You must be logged in to create a review.'
		redirect_to notes_path 
	end
	unless (@note = Note.where(:id => params[:note_id]).first)
		flash[:warning] = 'Review must be for an existing note.'
		redirect_to notes_path 
	end
end

end
