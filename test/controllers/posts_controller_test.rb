require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
     @post = posts(:orange) #user: michael
     @article_post = posts(:potato)
     @user = users(:michael)
     @other_user = users(:archer)
   end

  test "createアクション ログインなし" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum", genre: "article", link_url: "https://cookpad.com/" } }
    end
    assert_redirected_to login_url
  end

  test "createアクション URL正常" do
    log_in_as(@user)
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: "Lorem ipsum", genre: "article", link_url: "https://cookpad.com/" } }
    end
  end

  test "createアクション URL正規表現不正" do
    log_in_as(@user)
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum", genre: "article", link_url: "test.com" } }
    end
  end

  test "createアクション URL正規表現正常 存在しないURL" do
    log_in_as(@user)
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum", genre: "article", link_url: "https://cookpap.com/" } }
    end
  end


  test "editページへアクセス ログインなし" do
    get edit_post_path(@post) #HTTPリクエスト：get
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "updateアクション ログインなし" do
    patch post_path(@post), params: { post: { content: "change" } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "editページへアクセス 異なるユーザー" do
    log_in_as(@other_user)
    get edit_post_path(@post)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "editページへアクセス 正常ユーザー" do
    log_in_as(@user)
    get edit_post_path(@post), xhr: true
    assert_response :success
  end

  test "updateアクション 異なるユーザー" do
    log_in_as(@other_user)
    patch post_path(@post), params: { post: { content: "change!!!!" } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "destroyアクション ログインなし" do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end

  test "destroyアクション 異なるユーザー" do
    log_in_as(@other_user)
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to root_url
  end

  test "destroyアクション 正常" do
    log_in_as(@user)
    assert_difference 'Post.count', -1 do
      delete post_path(@post)
    end
  end

  # test "ajaxアクション" do
  #   get ajax_path(@genre), xhr: true #Ajax通信
  #   json_response = JSON.parse(response.body)
  #   assert_equal 200, json_response(@user)
  # end

end
