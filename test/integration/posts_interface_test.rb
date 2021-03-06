require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'genre: other 統合的投稿' do
    log_in_as(@user)
    post select_path, params: { data: 'other' }, xhr: true # Ajax通信
    assert_response :success
    # 無効な送信
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: '', genre: 'other' } }, xhr: true
    end
    assert_select 'li.error-list__item'
    # 有効な送信
    content = 'お腹すいた'
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: content, genre: 'other' } }, xhr: true
    end

    assert_match content, response.body
    get user_path(@user)

    # 投稿を削除する
    assert_select 'a.post-delete', text: '削除'
    first_post = @user.posts.page(1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post), xhr: true
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end

  test 'genre: article 統合的投稿' do
    log_in_as(@user)
    post select_path, params: { data: 'article' }, xhr: true # Ajax通信
    assert_response :success
    # 無効な送信
    content = 'お腹すいた'
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: content, genre: 'article', link_url: '' } }, xhr: true
    end
    assert_select 'li.error-list__item'
    # 有効な送信
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: content, genre: 'article', link_url: 'https://qiita.com/' } }
    end
    @post = Post.first
    assert_equal 'プログラマの技術情報共有サービス - Qiita', @post.link_title
    assert_equal 'Qiitaは、プログラマのための技術情報共有サービスです。 プログラミングに関するTips、ノウハウ、メモを簡単に記録 &amp; 公開することができます。', @post.link_desc
    assert_equal 'https://cdn.qiita.com/assets/qiita-fb-2887e7b4aad86fd8c25cea84846f2236.png', @post.link_image
  end

  test 'genre: book 統合的投稿' do
    log_in_as(@user)
    post select_path, params: { data: 'book' }, xhr: true # Ajax通信
    assert_response :success
    # 無効な送信
    content = 'お腹すいた'
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: content, genre: 'book', link_url: 'https://qiita.com/', book_evaluation: '' } }, xhr: true
    end
    assert_select 'li.error-list__item'
    # 有効な送信
    # 本検索(nokogiri)
    book_title = 'html'
    link_url = "https://www.amazon.co.jp/s?k=#{book_title}&__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&ref=nb_sb_noss_2"
    link_title = '1冊ですべて身につくHTML & CSSとWebデザイン入門講座'
    link_image = 'https://m.media-amazon.com/images/I/813E7x9kz7L._AC_UL320_.jpg'
    book_evaluation = 3
    get search_book_path, params: { content: book_title }, xhr: true
    assert_not $doc.nil?
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { content: content, genre: 'book', link_url: link_url, link_title: link_title, link_image: link_image, book_evaluation: book_evaluation } }
    end
  end

  test 'ユーザーページ 投稿数カウント' do
    log_in_as(@user)
    get user_path(@user)
    assert_select 'a.link--post-page' do
      assert_select 'span[class=?]', 'link__num link__num--post', text: @user.posts.count.to_s
    end
    # まだマイクロポストを投稿していないユーザー
    other_user = users(:malory)
    log_in_as(other_user)
    get user_path(other_user)
    assert_select 'a.link--post-page' do
      assert_select 'span[class=?]', 'link__num link__num--post', text: '0'
    end
    other_user.posts.create!(content: '知らない天井', genre: 'other')
    get user_path(other_user)
    assert_select 'a.link--post-page' do
      assert_select 'span[class=?]', 'link__num link__num--post', text: other_user.posts.count.to_s
    end
  end
end
