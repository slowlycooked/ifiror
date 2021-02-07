require "application_system_test_case"

class EmploymentsTest < ApplicationSystemTestCase
  setup do
    @employment = employments(:one)
  end

  test "visiting the index" do
    visit employments_url
    assert_selector "h1", text: "Employments"
  end

  test "creating a Employment" do
    visit employments_url
    click_on "New Employment"

    click_on "Create Employment"

    assert_text "Employment was successfully created"
    click_on "Back"
  end

  test "updating a Employment" do
    visit employments_url
    click_on "Edit", match: :first

    click_on "Update Employment"

    assert_text "Employment was successfully updated"
    click_on "Back"
  end

  test "destroying a Employment" do
    visit employments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Employment was successfully destroyed"
  end
end
