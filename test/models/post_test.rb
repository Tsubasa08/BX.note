require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @post = @user.posts.build(content: "Lorem ipsum")
  end

  # テストユーザー
  test "should be valid" do
    assert @post.valid?
  end

  # user_idが空
  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  # contentが空
  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  # contentが141文字以上
  test "content should be at most 140 characters" do
    @post.content = "a" * 141
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end
end
