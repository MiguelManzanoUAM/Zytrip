require "test_helper"

class AdditionalInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @additional_information = additional_informations(:one)
  end

  test "should get index" do
    get additional_informations_url
    assert_response :success
  end

  test "should get new" do
    get new_additional_information_url
    assert_response :success
  end

  test "should create additional_information" do
    assert_difference("AdditionalInformation.count") do
      post additional_informations_url, params: { additional_information: { description: @additional_information.description, image_url: @additional_information.image_url, phone_number: @additional_information.phone_number, slogan: @additional_information.slogan } }
    end

    assert_redirected_to additional_information_url(AdditionalInformation.last)
  end

  test "should show additional_information" do
    get additional_information_url(@additional_information)
    assert_response :success
  end

  test "should get edit" do
    get edit_additional_information_url(@additional_information)
    assert_response :success
  end

  test "should update additional_information" do
    patch additional_information_url(@additional_information), params: { additional_information: { description: @additional_information.description, image_url: @additional_information.image_url, phone_number: @additional_information.phone_number, slogan: @additional_information.slogan } }
    assert_redirected_to additional_information_url(@additional_information)
  end

  test "should destroy additional_information" do
    assert_difference("AdditionalInformation.count", -1) do
      delete additional_information_url(@additional_information)
    end

    assert_redirected_to additional_informations_url
  end
end
