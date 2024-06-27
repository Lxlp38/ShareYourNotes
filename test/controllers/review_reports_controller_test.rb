require "test_helper"

class ReviewReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review_report = review_reports(:one)
  end

  test "should get index" do
    get review_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_review_report_url
    assert_response :success
  end

  test "should create review_report" do
    assert_difference('ReviewReport.count') do
      post review_reports_url, params: { review_report: {  } }
    end

    assert_redirected_to review_report_url(ReviewReport.last)
  end

  test "should show review_report" do
    get review_report_url(@review_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_review_report_url(@review_report)
    assert_response :success
  end

  test "should update review_report" do
    patch review_report_url(@review_report), params: { review_report: {  } }
    assert_redirected_to review_report_url(@review_report)
  end

  test "should destroy review_report" do
    assert_difference('ReviewReport.count', -1) do
      delete review_report_url(@review_report)
    end

    assert_redirected_to review_reports_url
  end
end
