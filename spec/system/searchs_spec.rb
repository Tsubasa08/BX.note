require 'rails_helper'

describe '投稿検索機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:other_post, user: user)}

  before do
    visit root_path
  end

  context '検索結果が存在する場合' do
    before do
      fill_in '検索', with: 'テストです。'
      click_button 'button'
    end

    it '投稿が表示される' do
      expect(page).to have_selector "#post-#{post.id}"
    end
  end

  context '検索結果が存在しない場合' do
    before do
      fill_in '検索', with: 'お腹空いたー。'
      click_button 'button'
    end

    it '「xxxに一致する検索結果はありません」というメッセージが表示される' do
      expect(page).to have_content '「 お腹空いたー。 」に一致する検索結果はありません'
    end
  end
end