require 'rails_helper'

describe '投稿機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe '新規作成機能' do
    before do
      sign_in_as user
      find('#modal-open').click
    end
    context 'ジャンル：other' do
      before do
        click_button('その他')
        fill_in 'post_content', with: 'その他で投稿！'
        click_button 'シェア'
        # wait_for_css_disappear("#button-post[disableda]", 10) do
        #   click_button 'シェア'
        # end
      end

      it 'その他の投稿が正常の投稿されること' do
        # wait_for_ajax
        expect(page).to have_content '投稿を送信しました。'
      end
      
      it '投稿内容が表示されること' do
        # wait_for_ajax
        expect(page).to have_content 'その他で投稿！'
      end

      # it 'その他の投稿が正常の投稿されること' do
      #   expect {
      #     click_button 'シェア'
      #     # wait_for_ajax
      #   }.to change(Post, :count).by(1)
      #   # expect(page).to have_content '投稿を送信しました。'
      # end

      # it '投稿内容が表示されること' do
      #   expect {
      #     click_button 'シェア'
      #     wait_for_ajax
      #   }.to change(Post, :count).by(1)
      #   # expect(page).to have_content 'その他で投稿！'
      # end
    end

    context 'ジャンル：article' do
      before do
        click_button('記事共有')
        fill_in 'post_content', with: '記事共有で投稿！'
        fill_in 'post_link_url', with: 'https://qiita.com/'
        click_button 'シェア'
        # wait_for_css_disappear("#button-post.disabled", 10) do
        # end
      end

      it '記事共有の投稿が正常の投稿されること' do
        expect(page).to have_content '投稿を送信しました。'
      end

      it '投稿内容が表示されること' do
        expect(page).to have_content '記事共有で投稿！'
      end

      it 'OGP画像が表示されること' do
        expect(page).to have_selector 'img[src="https://cdn.qiita.com/assets/qiita-fb-2887e7b4aad86fd8c25cea84846f2236.png"]'
      end

      it 'OGPタイトルが表示されること' do
        expect(page).to have_content 'プログラマの技術情報共有サービス - Qiita'
      end

      it 'OGP概要が表示されること' do
        expect(page).to have_content 'Qiitaは、プログラマのための技術情報共有サービスです。 プログラミングに関するTips、ノウハウ、メモを簡単に記録 &amp; 公開することができます。'
      end

      it 'ホスト名が表示されること' do
        expect(page).to have_content 'qiita.com'
      end
    end

    describe 'ジャンル：book' do
      before do
        click_button('本の感想')
        find('label[for="post_book_evaluation_3"]').click
        fill_in 'post_content', with: '本の感想で投稿！'
        fill_in 'タイトル検索', with: ' 現場で使える Ruby on Rails 5速習実践ガイド '
        click_button 'book-serch'
        find('#book-label-1 .book-list__item').click
        # wait_for_css_disappear("#button-post.disabled", 15) do
        #   click_button 'シェア'
        # end
        click_button 'シェア'
      end
      # let(:book_title) { find('.book-title-text').value }
      # let(:book_title) { find('#post_link_title').value }

      it '本の感想の投稿が正常の投稿されること' do
        expect(page).to have_content '投稿を送信しました。'
      end
  
      it '本の感想の投稿内容が表示されること' do
        expect(page).to have_content '本の感想で投稿！'
      end
  
      it '本のサムネイルが表示されること' do
        expect(page).to have_selector 'img[src="https://m.media-amazon.com/images/I/71FB8RzWdsL._AC_UL320_.jpg"]'
      end
  
      it '本のタイトルが表示されること' do
        expect(page).to have_content '現場で使える Ruby on Rails 5速習実践ガイド'
      end
  
      it 'ホスト名が表示されること' do
        expect(page).to have_content 'amazon.com'
      end
    end
  end
end