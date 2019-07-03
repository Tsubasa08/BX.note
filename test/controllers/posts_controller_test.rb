require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
     @post = posts(:orange)
   end

  test "createアクション ログインなし" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum", genre: "article", link_url: "https://cookpad.com/" } }
    end
    assert_redirected_to login_url
  end

  test "createアクション URL正常" do
    log_in_as(users(:michael))
    assert_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum", genre: "article", link_url: "https://cookpad.com/" } }
    end
  end

  test "createアクション URL正規表現不正" do
    log_in_as(users(:michael))
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum", genre: "article", link_url: "test.com" } }
    end
  end

  test "createアクション URL正規表現正常 存在しないURL" do
    log_in_as(users(:michael))
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum", genre: "article", link_url: "https://cookpap.com/" } }
    end
  end

  test "destroyアクション ログインなし" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end

  # test "ajaxアクション" do
  #   get ajax_path(@genre), xhr: true #Ajax通信
  #   json_response = JSON.parse(response.body)
  #   assert_equal 200, json_response(@user)
  # end

  #間違ったユーザーによるマイクロポスト削除に対してテスト
  #  test "should redirect destroy for wrong post" do
  #   log_in_as(users(:michael))
  #   post = posts(:ants)
  #   assert_no_difference 'Post.count' do
  #     delete post_path(post)
  #   end
  #   assert_redirected_to root_url
  # end
end
