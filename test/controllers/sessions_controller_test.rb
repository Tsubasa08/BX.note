require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'ログインページへアクセス' do
    get login_path
    assert_response :success
  end
end
