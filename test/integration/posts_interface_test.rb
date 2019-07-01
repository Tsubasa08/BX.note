require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "統合的投稿" do
    log_in_as(@user)
    post select_path, params: { data: "other"}, xhr: true #Ajax通信
    get ajax_path(@genre) #Ajax通信
    assert_response :success
    # assert_select 'div.pagination'
    # assert_select 'div', count:1
    # 無効な送信
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "", genre: "other" } }
    end
    # assert_select 'div#error_explanation'
    # 有効な送信
    # picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    content = "お腹すいた"
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: content, genre: "other"  } }
    end
    # assert assigns(:post).picture?
    assert_redirected_to root_url
    follow_redirect!
    # assert_match content, response.body
    # 投稿を削除する
    # assert_select 'a', text: 'delete'
    # first_micropost = @user.microposts.paginate(page: 1).first
    # assert_difference 'Micropost.count', -1 do
    #   delete micropost_path(first_micropost)
    # end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    # get user_path(users(:archer))
    # assert_select 'a', text: 'delete', count: 0
  end

  # サイドバーのマイクロポストの投稿数をテスト
  # test "micropost sidebar count" do
  #   log_in_as(@user)
  #   get root_path
  #   assert_match "#{@user.microposts.count} microposts", response.body
  #   # まだマイクロポストを投稿していないユーザー
  #   other_user = users(:malory)
  #   log_in_as(other_user)
  #   get root_path
  #   assert_match "0 microposts", response.body
  #   other_user.microposts.create!(content: "A micropost")
  #   get root_path
  #   assert_match "1 micropost", response.body
  # end

end
