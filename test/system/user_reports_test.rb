require "application_system_test_case"

class UserReportsTest < ApplicationSystemTestCase
  setup do
    @user_report = user_reports(:one)
  end

  test "visiting the index" do
    visit user_reports_url
    assert_selector "h1", text: "User Reports"
  end

  test "creating a User report" do
    visit user_reports_url
    click_on "New User Report"

    click_on "Create User report"

    assert_text "User report was successfully created"
    click_on "Back"
  end

  test "updating a User report" do
    visit user_reports_url
    click_on "Edit", match: :first

    click_on "Update User report"

    assert_text "User report was successfully updated"
    click_on "Back"
  end

  test "destroying a User report" do
    visit user_reports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User report was successfully destroyed"
  end
end
