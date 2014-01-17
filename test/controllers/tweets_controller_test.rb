require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  test "should get last" do
    get :last
    assert_response :success
  end

end
