require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # has_many :post_categories
  # has_many :categories, through: :post_categories

  def setup
    @user = users(:michael)
    @post = @user.posts.build(content: "Lorem ipsum", genre: "other")
  end

  # テストユーザー
  test "content,genreあり" do
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


  test "user_idが空" do
    @post.user_id = nil
    assert_not @post.valid?
  end


  test "contentが空" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "contentが141文字以上" do
    @post.content = "a" * 141
    assert_not @post.valid?
  end


  test "genreが空" do
    @post.genre = "   "
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end

end
