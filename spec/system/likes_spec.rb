require 'rails_helper'

describe 'いいね機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:other_post, user: other_user)}

  describe 'いいねしていない場合' do
    before do
      sign_in_as user
      visit root_path
      find(".like-#{post.id} .heart-icon").click
      wait_for_ajax
    end

    it 'いいねアイコンが活性化する' do
      expect(page).to have_css '.like-btn--unlike'
    end

    it 'いいね数が「1」と表示される' do
      expect(page).to have_selector '.like-btn--unlike', text: "#{post.likes.count}"
    end

    context 'いいね一覧ページへアクセスした場合' do
      before do
        visit likes_user_path(user)
      end

      it 'いいね一覧ページにいいねした投稿が表示されること' do
        expect(page).to have_selector "#post-#{post.id}"
      end
    end
  end

  describe 'いいね済み場合' do
    before do
      FactoryBot.create(:like, user: user, post: post)
      sign_in_as user
      visit root_path
      find(".like-#{post.id} .heart-icon").click
      wait_for_ajax
    end

    it 'いいねアイコンが非活性化する' do
      expect(page).to have_css '.like-btn--like'
    end

    it 'いいね数が「''」と表示される' do
      expect(page).to have_selector '.like-btn--like', text: ''
    end

    context 'いいね一覧ページへアクセスした場合' do
      before do
        visit likes_user_path(user)
      end

      it 'いいね一覧ページにいいねした投稿が表示されないこと' do
        expect(page).to_not have_selector "#post-#{post.id}"
      end
    end
  end
end