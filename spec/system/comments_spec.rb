require 'rails_helper'

describe 'コメント投稿機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:other_post, user: user)}
  let!(:comment) { FactoryBot.create(:comment, user: user, post: post)}

  context '新規作成機能' do
    before do
      sign_in_as user
      find('.post-show-link').click #投稿詳細画面をモーダルウィンドウで開く(Ajax通信)
      fill_in 'comment[content]', with: "コメントテスト"
      click_button '送信'
    end

    it 'コメントの投稿内容が表示されること' do
      expect(page).to have_content 'コメントテスト'
    end

    # it 'コメントが正常の投稿されること' do
    #   expect {
    #     fill_in 'comment[content]', with: "コメントテスト"
    #     click_button '送信'
    #     wait_for_ajax
    #   }.to change(Comment, :count).by(1)
    # end
  end

  context '削除機能' do
    before do
      sign_in_as user
      find('.post-show-link').click 
      find('.user-link__delete').click
      page.driver.browser.switch_to.alert.accept
      wait_for_ajax
    end

    it 'コメントの投稿内容が表示されていないこと' do
      expect(page).to_not have_content 'テストコメント'
    end

  end
end