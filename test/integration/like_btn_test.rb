require 'test_helper'

class LikeBtnTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other = users(:archer)
    @post = posts(:apple) #(user: archer)
  end

  # 普通の通信とAjax通信に分けてテスト
   test "いいね機能(普通の通信)" do
    log_in_as(@user)    
    assert_difference '@post.likes.count', 1 do
      post like_path(@post.id)
    end
  end

  test "いいね機能(Ajax通信)" do
    log_in_as(@user)
    assert_difference '@post.likes.count', 1 do
      post like_path(@post.id), xhr: true
    end
  end

  test "いいね解除機能(普通の通信)" do
    log_in_as(@user)
    @post.like(@user)
    assert_difference '@post.likes.count', -1 do
      delete like_path(@post.id)
    end
  end

  test "いいね解除機能(Ajax通信)" do
    log_in_as(@user)
    @post.like(@user)
    assert_difference '@post.likes.count', -1 do
      delete like_path(@post.id), xhr: true
    end
  end


  test "ログインしていないユーザーがいいね機能/いいね解除機能" do
    @post.like(@user)
    assert_no_difference '@post.likes.count' do
      post like_path(@post.id)
    end
    assert_no_difference '@post.likes.count' do
      post like_path(@post.id), xhr: true
    end
    assert_no_difference '@post.likes.count' do
      delete like_path(@post.id)
    end
    assert_no_difference '@post.likes.count' do
      delete like_path(@post.id), xhr: true
    end
  end

  test "自分で自分の投稿にいいね/いいね解除(普通の通信)" do
    log_in_as(@other)
    assert_difference '@post.likes.count', 1 do
      post like_path(@post.id)
    end
    assert_difference '@post.likes.count', -1 do
      delete like_path(@post.id)
    end
  end

  test "自分で自分の投稿にいいね/いいね解除(Ajax通信)" do
    log_in_as(@other)
    assert_difference '@post.likes.count', 1 do
      post like_path(@post.id), xhr: true
    end
    assert_difference '@post.likes.count', -1 do
      delete like_path(@post.id), xhr: true
    end
  end

  test "ログインしていないユーザーのいいねボタンレイアウト" do
    log_in_as(@other)
    post like_path(@post.id), xhr: true
    get user_path(@other)
    assert_select "a[href=?]", like_path(@post.id)
    delete logout_path
    get user_path(@other)
    assert_select "a[href=?]", like_path(@post.id), count: 0
    #いいねの数
    assert_select "span[class=?]", "like-btn--like"
  end

end
