require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get weekly_stats" do
    get reports_weekly_stats_url
    assert_response :success
  end
end
