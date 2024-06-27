require "application_system_test_case"

class ReviewReportsTest < ApplicationSystemTestCase
  setup do
    @review_report = review_reports(:one)
  end

  test "visiting the index" do
    visit review_reports_url
    assert_selector "h1", text: "Review Reports"
  end

  test "creating a Review report" do
    visit review_reports_url
    click_on "New Review Report"

    click_on "Create Review report"

    assert_text "Review report was successfully created"
    click_on "Back"
  end

  test "updating a Review report" do
    visit review_reports_url
    click_on "Edit", match: :first

    click_on "Update Review report"

    assert_text "Review report was successfully updated"
    click_on "Back"
  end

  test "destroying a Review report" do
    visit review_reports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Review report was successfully destroyed"
  end
end
