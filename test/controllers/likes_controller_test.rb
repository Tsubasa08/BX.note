require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "ログインしていないユーザーでpost" do
    assert_no_difference 'Like.count' do
      post like_path(1)
    end
    assert_redirected_to login_path
  end

  test "ログインしていないユーザーでdelete" do
    assert_no_difference 'Like.count' do
      post unlike_path(1)
    end
    assert_redirected_to login_path
  end


end
