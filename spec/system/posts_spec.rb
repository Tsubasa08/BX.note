require 'rails_helper'

describe '投稿機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:other_post, user: other_user)}

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
        wait_for_ajax
      end

      it 'その他の投稿が正常の投稿されること' do
        expect(page).to have_content '投稿を送信しました。'
      end
      
      it '投稿内容が表示されること' do
        expect(page).to have_content 'その他で投稿！'
      end
    end

    context 'ジャンル：article' do
      before do
        click_button('記事共有')
        fill_in 'post_content', with: '記事共有で投稿！'
        fill_in 'post_link_url', with: 'https://qiita.com/'
        click_button 'シェア'
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

    context 'ジャンル：book' do
      before do
        click_button('本の感想')
        find('label[for="post_book_evaluation_3"]').click
        fill_in 'post_content', with: '本の感想で投稿！'
        fill_in 'タイトル検索', with: ' 現場で使える Ruby on Rails 5速習実践ガイド '
        click_button 'book-serch'
        wait_for_ajax
        find('#book-label-1 .book-list__item').click
        click_button 'シェア'
      end

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

    context 'カテゴリーを選択した場合' do
      before do
        click_button('その他')
        fill_in 'post_content', with: 'その他で投稿！'
        find('label[for="post_category_ids_1"]').click
        find('label[for="post_category_ids_5"]').click
        click_button 'シェア'
        wait_for_ajax
      end
  
      it '投稿にカテゴリーが表示されていること' do
        expect(page).to have_selector '.categories__link', text: 'HTML'
        expect(page).to have_selector '.categories__link', text: 'WordPress'
      end
    end

    context '画像を選択した場合' do
      before do
        click_button('その他')
        fill_in 'post_content', with: 'その他で投稿！'
        attach_file("post[images][]", "#{Rails.root}/spec/images/sample-img_kaeru.jpg", visible: false)
        click_button 'シェア'
        wait_for_ajax
      end
  
      it '投稿に画像が表示されていること' do
        expect(page).to have_selector '.slider__item img'
      end
    end
  end


  describe '一覧表示機能' do
    context 'トップページにアクセスした場合' do
      before do
        visit root_path
      end

      it 'トップページに投稿が表示されること' do
        expect(page).to have_selector "#post-#{post.id}"
      end
    end

    context 'ユーザー詳細ページにアクセスした場合' do
      before do
        visit user_path(other_user)
      end

      it 'ユーザー詳細ページに投稿が表示されること' do
        expect(page).to have_selector "#post-#{post.id}"
      end
    end
  end

  describe '削除機能' do
    before do
      sign_in_as other_user
      find("#post-#{post.id} .post-meta-icon").click
      click_link '削除'
      page.driver.browser.switch_to.alert.accept
      wait_for_ajax
    end

    it '投稿を削除できること' do
      expect(page).to have_content '投稿を削除しました。'
      expect(page).to_not have_selector "#post-#{post.id}"
    end
  end

  describe '編集機能' do
    before do
      sign_in_as other_user
      find("#post-#{post.id} .post-meta-icon").click
      click_link '編集する'
      wait_for_ajax
      fill_in 'post_content', with: 'テストです。投稿を編集。'
      click_button '保存'
      wait_for_ajax
    end

    it '投稿を編集できること' do
      expect(page).to have_content '投稿を保存しました。'
      expect(page).to have_content 'テストです。投稿を編集。'
    end
  end
  
end