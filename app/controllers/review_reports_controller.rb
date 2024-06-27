class ReviewReportsController < ApplicationController
  before_action :set_review_report, only: %i[ show edit update destroy ]

  # GET /review_reports or /review_reports.json
  def index
    @review_reports = ReviewReport.all
  end

  # GET /review_reports/1 or /review_reports/1.json
  def show
  end

  # GET /review_reports/new
  def new
    @review_report = ReviewReport.new
  end

  # GET /review_reports/1/edit
  def edit
  end

  # POST /review_reports or /review_reports.json
  def create
    @review_report = ReviewReport.new(review_report_params)

    respond_to do |format|
      if @review_report.save
        format.html { redirect_to request.referrer, notice: "Review report was successfully transmitted." } # redirect_to review_report_url(@review_report)
        format.json { render :show, status: :created, location: @review_report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /review_reports/1 or /review_reports/1.json
  def update
    respond_to do |format|
      if @review_report.update(review_report_params)
        format.html { redirect_to review_report_url(@review_report), notice: "Review report was successfully updated." }
        format.json { render :show, status: :ok, location: @review_report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /review_reports/1 or /review_reports/1.json
  def destroy
    @review_report.destroy

    respond_to do |format|
      format.html { redirect_to review_reports_url, notice: "Review report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review_report
      @review_report = ReviewReport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_report_params
      params.require(:review_report).permit(:review_report, :review_id, :subject, :report)
    end
end
