require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get client" do
    get welcome_client_url
    assert_response :success
  end

end
