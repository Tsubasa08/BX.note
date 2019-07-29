require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @post_other = @user.posts.build(content: 'Lorem ipsum', genre: 'other')
    @post_article = @user.posts.build(content: 'Lorem ipsum', genre: 'article', link_url: 'https://qiita.com/')
    @post_book = @user.posts.build(content: 'Lorem ipsum', genre: 'book', link_url: 'https://qiita.com/', book_evaluation: 5)
  end

  test 'カテゴリー配列あり' do
    @post_other.category_ids = [1, 2, 7]
    assert @post_other.valid?
  end

  test 'カテゴリー配列が空' do
    @post_other.category_ids = []
    assert @post_other.valid?
  end

  test 'user_idが空' do
    @post_other.user_id = nil
    assert_not @post_other.valid?
  end

  test 'contentが空' do
    @post_other.content = '   '
    assert_not @post_other.valid?
  end

  test 'contentが141文字以上' do
    @post_other.content = 'a' * 141
    assert_not @post_other.valid?
  end

  test 'genreが空' do
    @post_other.genre = '   '
    assert_not @post_other.valid?
  end

  test 'モデルの最初の投稿が直近の投稿' do
    assert_equal posts(:most_recent), Post.first
  end

  # genre: other
  test 'バリデーションクリア条件' do
    assert @post_other.valid?
  end

  # genre: article
  test 'バリデーションクリア条件 genre: article' do
    assert @post_article.valid?
  end

  test 'リンクURLが正しい正規表現 genre: article' do
    valid_urls = %w[https://example.com http://example.com https://example.com/test
                    http://example.com/test]
    valid_urls.each do |url|
      @post_article.link_url = url
      assert @post_article.valid?
    end
  end

  test 'リンクURLが不正な正規表現 genre: article' do
    invalid_urls = %w[https:/example.com http:/example.com https//example.com
                      http//example.com example.com]
    invalid_urls.each do |url|
      @post_article.link_url = url
      assert_not @post_article.valid?
    end
  end

  test 'リンクURLが空 genre: article' do
    @post_article.link_url = ''
    assert_not @post_article.valid?
  end

  # genre: book
  test 'バリデーションクリア条件 genre: book' do
    assert @post_book.valid?
  end

  test 'リンクURLが正しい正規表現 genre: book' do
    valid_urls = %w[https://example.com http://example.com https://example.com/test
                    http://example.com/test]
    valid_urls.each do |url|
      @post_book.link_url = url
      assert @post_book.valid?
    end
  end

  test 'リンクURLが不正な正規表現 genre: book' do
    invalid_urls = %w[https:/example.com http:/example.com https//example.com
                      http//example.com example.com]
    invalid_urls.each do |url|
      @post_book.link_url = url
      assert_not @post_book.valid?
    end
  end

  test 'リンクURLが空 genre: book' do
    @post_book.link_url = ''
    assert_not @post_book.valid?
  end

  test '本の評価が空 genre: book' do
    @post_book.book_evaluation = ''
    assert_not @post_book.valid?
  end
end
