require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "genre: other 統合的投稿" do
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
    content = "お腹すいた"
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: content, genre: "other"  } }
    end
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

  test "genre: article 統合的投稿" do
    log_in_as(@user)
    post select_path, params: { data: "article"}, xhr: true #Ajax通信
    get ajax_path(@genre) #Ajax通信
    assert_response :success
    # assert_select 'div.pagination'
    # assert_select 'div', count:1
    # 無効な送信
    content = "お腹すいた"
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: content, genre: "article", link_url: ""  } }
    end
    # assert_select 'div#error_explanation'
    # 有効な送信
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: content, genre: "article", link_url: "https://qiita.com/"  } }
    end
    @post = Post.first
    assert_equal "プログラマの技術情報共有サービス - Qiita", @post.link_title
    assert_equal "Qiitaは、プログラマのための技術情報共有サービスです。 プログラミングに関するTips、ノウハウ、メモを簡単に記録 &amp; 公開することができます。", @post.link_desc
    assert_equal "https://cdn.qiita.com/assets/qiita-fb-2887e7b4aad86fd8c25cea84846f2236.png", @post.link_image
    assert_redirected_to root_url
    follow_redirect!
  end

  test "genre: book 統合的投稿" do
    log_in_as(@user)
    post select_path, params: { data: "book"}, xhr: true #Ajax通信
    get ajax_path(@genre) #Ajax通信
    assert_response :success
    # assert_select 'div.pagination'
    # assert_select 'div', count:1
    # 無効な送信
    content = "お腹すいた"
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: content, genre: "book", link_url: "https://qiita.com/"  } }
    end
    # assert_select 'div#error_explanation'
    # 有効な送信
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: content, genre: "book", link_url: "https://qiita.com/"  } }
    end
    @post = Post.first
    assert_equal "プログラマの技術情報共有サービス - Qiita", @post.link_title
    assert_equal "Qiitaは、プログラマのための技術情報共有サービスです。 プログラミングに関するTips、ノウハウ、メモを簡単に記録 &amp; 公開することができます。", @post.link_desc
    assert_equal "https://cdn.qiita.com/assets/qiita-fb-2887e7b4aad86fd8c25cea84846f2236.png", @post.link_image
    assert_redirected_to root_url
    follow_redirect!
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
