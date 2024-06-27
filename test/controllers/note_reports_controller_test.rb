require "test_helper"

class NoteReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @note_report = note_reports(:one)
  end

  test "should get index" do
    get note_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_note_report_url
    assert_response :success
  end

  test "should create note_report" do
    assert_difference('NoteReport.count') do
      post note_reports_url, params: { note_report: {  } }
    end

    assert_redirected_to note_report_url(NoteReport.last)
  end

  test "should show note_report" do
    get note_report_url(@note_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_note_report_url(@note_report)
    assert_response :success
  end

  test "should update note_report" do
    patch note_report_url(@note_report), params: { note_report: {  } }
    assert_redirected_to note_report_url(@note_report)
  end

  test "should destroy note_report" do
    assert_difference('NoteReport.count', -1) do
      delete note_report_url(@note_report)
    end

    assert_redirected_to note_reports_url
  end
end
