require 'test_helper'

class PostsCommunicationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:orange)
    @post_data = { content: 'hello world!!', genre: 'other' }
    log_in_as(@user)
  end

  # 普通の通信とAjax通信に分けてテスト
  test '投稿詳細機能(普通の通信)' do
    get post_path(@post)
    assert_redirected_to root_url
  end

  test '投稿詳細機能(Ajax通信)' do
    get post_path(@post), xhr: true
    assert_response :success
  end

  test '投稿作成機能(普通の通信)' do
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: @post_data }
    end
  end

  test '投稿作成機能(Ajax通信)' do
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: @post_data }, xhr: true
    end
  end

  test '投稿削除機能(普通の通信)' do
    assert_difference 'Post.count', -1 do
      delete post_path(@post)
    end
  end

  test '投稿削除機能(Ajax通信)' do
    assert_difference 'Post.count', -1 do
      delete post_path(@post), xhr: true
    end
  end

  test '投稿編集機能(edit)(普通の通信)' do
    get edit_post_path(@post)
    assert_redirected_to root_url
  end

  test '投稿編集機能(edit)(Ajax通信)' do
    get edit_post_path(@post), xhr: true
    assert_response :success
  end

  test '投稿編集機能(update)(普通の通信)' do
    content = 'hello japan!!'
    # genreは隠しinputで入力済み
    patch post_path(@post), params: { post: { content: content } }
    assert_redirected_to root_url
  end

  test '投稿編集機能(update)(Ajax通信)' do
    content = 'hello japan!!'
    # genreは隠しinputで入力済み
    patch post_path(@post), params: { post: { content: content } }, xhr: true
    assert_response :success
  end
end
