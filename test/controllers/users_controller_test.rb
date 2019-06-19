require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    # @non_activated_user = users(:jon)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

end
