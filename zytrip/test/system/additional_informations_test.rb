require "application_system_test_case"

class AdditionalInformationsTest < ApplicationSystemTestCase
  setup do
    @additional_information = additional_informations(:one)
  end

  test "visiting the index" do
    visit additional_informations_url
    assert_selector "h1", text: "Additional information"
  end

  test "should create additional information" do
    visit additional_informations_url
    click_on "New additional information"

    fill_in "Description", with: @additional_information.description
    fill_in "Image url", with: @additional_information.image_url
    fill_in "Phone number", with: @additional_information.phone_number
    fill_in "Slogan", with: @additional_information.slogan
    click_on "Create Additional information"

    assert_text "Additional information was successfully created"
    click_on "Back"
  end

  test "should update Additional information" do
    visit additional_information_url(@additional_information)
    click_on "Edit this additional information", match: :first

    fill_in "Description", with: @additional_information.description
    fill_in "Image url", with: @additional_information.image_url
    fill_in "Phone number", with: @additional_information.phone_number
    fill_in "Slogan", with: @additional_information.slogan
    click_on "Update Additional information"

    assert_text "Additional information was successfully updated"
    click_on "Back"
  end

  test "should destroy Additional information" do
    visit additional_information_url(@additional_information)
    click_on "Destroy this additional information", match: :first

    assert_text "Additional information was successfully destroyed"
  end
end
