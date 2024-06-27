require "application_system_test_case"

class NoteReportsTest < ApplicationSystemTestCase
  setup do
    @note_report = note_reports(:one)
  end

  test "visiting the index" do
    visit note_reports_url
    assert_selector "h1", text: "Note Reports"
  end

  test "creating a Note report" do
    visit note_reports_url
    click_on "New Note Report"

    click_on "Create Note report"

    assert_text "Note report was successfully created"
    click_on "Back"
  end

  test "updating a Note report" do
    visit note_reports_url
    click_on "Edit", match: :first

    click_on "Update Note report"

    assert_text "Note report was successfully updated"
    click_on "Back"
  end

  test "destroying a Note report" do
    visit note_reports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Note report was successfully destroyed"
  end
end
