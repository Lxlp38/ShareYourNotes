class NoteReportsController < ApplicationController
  before_action :set_note_report, only: %i[ show edit update destroy ]

  # GET /note_reports or /note_reports.json
  def index
    @note_reports = NoteReport.all
  end

  # GET /note_reports/1 or /note_reports/1.json
  def show
  end

  # GET /note_reports/new
  def new
    @note_report = NoteReport.new
  end

  # GET /note_reports/1/edit
  def edit
  end

  # POST /note_reports or /note_reports.json
  def create
    @note_report = NoteReport.new(note_report_params)

    respond_to do |format|
      if @note_report.save
        format.html { redirect_to note_report_url(@note_report), notice: "Note report was successfully created." }
        format.json { render :show, status: :created, location: @note_report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /note_reports/1 or /note_reports/1.json
  def update
    respond_to do |format|
      if @note_report.update(note_report_params)
        format.html { redirect_to note_report_url(@note_report), notice: "Note report was successfully updated." }
        format.json { render :show, status: :ok, location: @note_report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /note_reports/1 or /note_reports/1.json
  def destroy
    @note_report.destroy

    respond_to do |format|
      format.html { redirect_to note_reports_url, notice: "Note report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note_report
      @note_report = NoteReport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_report_params
      params.require(:note_report).permit(:note_report, :note_id, :subject, :report)
    end
end
