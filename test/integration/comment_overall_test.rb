require 'test_helper'

class CommentOverallTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other = users(:archer)
    @post = posts(:apple) # (id: 2, user: archer)
    @comment = comments(:one) # (user: michael, post user:michael)
  end

  # 普通の通信とAjax通信に分けてテスト
  test 'コメント機能(普通の通信)' do
    log_in_as(@user)
    assert_difference '@post.comments.count', 1 do
      post comments_path, params: { comment: { user_id: @user.id, post_id: @post.id, content: 'パターン青' } }
    end
  end

  test 'コメント機能(Ajax通信)' do
    log_in_as(@user)
    assert_difference '@post.comments.count', 1 do
      post comments_path, params: { comment: { user_id: @user.id, post_id: @post.id, content: 'パターン青' } }, xhr: true
    end
  end

  test 'コメント解除機能(普通の通信)' do
    log_in_as(@user)
    post comments_path, params: { comment: { user_id: @user.id, post_id: @post.id, content: 'パターン青' } }
    @comment = Comment.find_by(post_id: @post.id)
    assert_difference '@post.comments.count', -1 do
      delete comment_path(@comment)
    end
  end

  test 'コメント解除機能(Ajax通信)' do
    log_in_as(@user)
    post comments_path, params: { comment: { user_id: @user.id, post_id: @post.id, content: 'パターン青' } }
    comment = Comment.find_by(post_id: @post.id)
    assert_difference '@post.comments.count', -1 do
      delete comment_path(comment), xhr: true
    end
  end

  test 'ログインしていないユーザーがコメント機能/コメント削除機能' do
    assert_no_difference '@post.comments.count' do
      post comments_path, params: { comment: { user_id: @user.id, post_id: @post.id, content: 'パターン青' } }
    end
    assert_no_difference '@post.comments.count' do
      post comments_path, params: { comment: { user_id: @user.id, post_id: @post.id, content: 'パターン青' } }, xhr: true
    end
    assert_no_difference '@post.comments.count' do
      delete comment_path(@comment)
    end
    assert_no_difference '@post.comments.count' do
      delete comment_path(@comment), xhr: true
    end
  end

  test '自分で自分の投稿にコメント/コメント解除(普通の通信)' do
    log_in_as(@other)
    assert_difference '@post.comments.count', 1 do
      post comments_path, params: { comment: { user_id: @other.id, post_id: @post.id, content: 'パターン青' } }
    end
    comment = Comment.find_by(post_id: @post.id)
    assert_difference '@post.comments.count', -1 do
      delete comment_path(comment)
    end
  end

  test '自分で自分の投稿にコメント/コメント解除(Ajax通信)' do
    log_in_as(@other)
    assert_difference '@post.comments.count', 1 do
      post comments_path, params: { comment: { user_id: @other.id, post_id: @post.id, content: 'パターン青' } }, xhr: true
    end
    comment = Comment.find_by(post_id: @post.id)
    assert_difference '@post.comments.count', -1 do
      delete comment_path(comment), xhr: true
    end
  end

  test 'ログインしていないユーザーのコメントアイコンレイアウト' do
    log_in_as(@other)
    post comments_path, params: { comment: { user_id: @other.id, post_id: @post.id, content: 'パターン青' } }, xhr: true
    get user_path(@other)
    assert_select 'div[id=tab-menu]', class: 'tab-menu'
    assert_select 'a[class=?]', 'post-show-link exist', href: post_path(@post.id).to_s
    delete logout_path
    get user_path(@other)
    assert_select 'a[class=?]', 'post-show-link exist', href: post_path(@post.id).to_s, count: 0
    # コメントの数
    assert_select 'span[class=?]', "comment-btn comment-btn--#{@post.id}", text: @post.comments.count.to_s
  end

  test 'コメントの数が0' do
    get user_path(@other)
    assert_select 'span[class=?]', "comment-btn comment-btn--#{@post.id}", text: ''
    log_in_as(@other)
    get user_path(@other)
    assert_select 'span[class=?]', "comment-btn comment-btn--#{@post.id}", text: ''
    delete logout_path
    log_in_as(@user)
    get user_path(@other)
    assert_select 'span[class=?]', "comment-btn comment-btn--#{@post.id}", text: ''
  end
end
