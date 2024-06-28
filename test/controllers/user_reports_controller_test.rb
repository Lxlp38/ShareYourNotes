require "test_helper"

class UserReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_report = user_reports(:one)
  end

  test "should get index" do
    get user_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_user_report_url
    assert_response :success
  end

  test "should create user_report" do
    assert_difference('UserReport.count') do
      post user_reports_url, params: { user_report: {  } }
    end

    assert_redirected_to user_report_url(UserReport.last)
  end

  test "should show user_report" do
    get user_report_url(@user_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_report_url(@user_report)
    assert_response :success
  end

  test "should update user_report" do
    patch user_report_url(@user_report), params: { user_report: {  } }
    assert_redirected_to user_report_url(@user_report)
  end

  test "should destroy user_report" do
    assert_difference('UserReport.count', -1) do
      delete user_report_url(@user_report)
    end

    assert_redirected_to user_reports_url
  end
end
