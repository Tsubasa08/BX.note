require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
     @comment = comments(:one) #(user: michael, post user:michael)
   end

  test "createアクション ログインなし" do
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: {user_id: "1", post_id: "1", content: "総員 第一種戦闘配置"} }
    end
    assert_redirected_to login_url
  end

  test "createアクション 正常" do
    log_in_as(users(:michael))
    assert_difference 'Comment.count', 1 do
      post comments_path, params: { comment: {post_id: "1", content: "総員 第一種戦闘配置"} }
    end
  end

  test "destroyアクション ログインなし" do
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to login_url
  end

  test "destroyアクション 正常" do
    log_in_as(users(:michael))
    assert_difference 'Comment.count', -1 do
      delete comment_path(@comment)
    end
  end
  
end
