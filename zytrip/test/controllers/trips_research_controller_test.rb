require "test_helper"

class TripsResearchControllerTest < ActionDispatch::IntegrationTest
  test "should get survey" do
    get trips_research_survey_url
    assert_response :success
  end

  test "should get results" do
    get trips_research_results_url
    assert_response :success
  end
end
