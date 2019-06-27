require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # has_many :post_categories
  # has_many :categories, through: :post_categories

  def setup
    @user = users(:michael)
    @post = @user.posts.build(content: "Lorem ipsum")
  end

  # テストユーザー
  test "contentあり" do
    assert @post.valid?
  end

  test "カテゴリー配列あり" do
    @post.category_ids = [1,2,7]
    assert @post.valid?
  end

  test "カテゴリー配列が空" do
    @post.category_ids = []
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
