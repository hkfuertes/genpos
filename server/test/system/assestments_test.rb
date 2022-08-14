require "application_system_test_case"

class AssestmentsTest < ApplicationSystemTestCase
  setup do
    @assestment = assestments(:one)
  end

  test "visiting the index" do
    visit assestments_url
    assert_selector "h1", text: "Assestments"
  end

  test "should create assestment" do
    visit assestments_url
    click_on "New assestment"

    click_on "Create Assestment"

    assert_text "Assestment was successfully created"
    click_on "Back"
  end

  test "should update Assestment" do
    visit assestment_url(@assestment)
    click_on "Edit this assestment", match: :first

    click_on "Update Assestment"

    assert_text "Assestment was successfully updated"
    click_on "Back"
  end

  test "should destroy Assestment" do
    visit assestment_url(@assestment)
    click_on "Destroy this assestment", match: :first

    assert_text "Assestment was successfully destroyed"
  end
end
