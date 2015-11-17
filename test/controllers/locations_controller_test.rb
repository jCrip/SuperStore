require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  test "should get get_address" do
    get :get_address
    assert_response :success
  end

end
