require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:book_post) { FactoryBot.create(:book_post) }
  let(:article_post) { FactoryBot.create(:article_post) }
  let(:other_post) { FactoryBot.create(:other_post) }

  describe '投稿が有効' do
    it 'ジャンル：bookの投稿が有効であること' do
      expect(book_post).to be_valid
    end

    it 'ジャンル：articleの投稿が有効であること' do
      expect(article_post).to be_valid
    end

    it 'ジャンル：otherの投稿が有効であること' do
      expect(other_post).to be_valid
    end
  end


  describe '投稿が無効' do
    it 'ジャンルが存在しない場合' do
      other_post.genre = ''
      expect(other_post).to_not be_valid
    end

    it '投稿内容が141文字以上の場合無効であること' do
      other_post.content = 'a' * 141
      expect(other_post).to_not be_valid
    end

    it '投稿内容が存在しない場合無効であること' do
      book_post.content = ''
      expect(book_post).to_not be_valid
    end

    context 'リンクURLが存在しない場合' do
      it 'ジャンル：bookのリンクURLが存在しない場合無効であること' do
        book_post.link_url = ''
        expect(book_post).to_not be_valid
      end

      it 'ジャンル：articleのリンクURLが存在しない場合無効であること' do
        article_post.link_url = ''
        expect(article_post).to_not be_valid
      end
    end

    context 'リンクURLが不正な正規表現の場合無効であること' do
      it 'ジャンル：bookのリンクURLが不正な正規表現の場合無効であること' do
        invalid_urls = %w[https:/example.com http:/example.com https//example.com http//example.com example.com]
        invalid_urls.each do |url|
          book_post.link_url = url
          expect(book_post).to_not be_valid
        end
      end

      it 'ジャンル：articleのリンクURLが不正な正規表現の場合無効であること' do
        invalid_urls = %w[https:/example.com http:/example.com https//example.com http//example.com example.com]
        invalid_urls.each do |url|
          article_post.link_url = url
          expect(article_post).to_not be_valid
        end
      end
    end
  end
end