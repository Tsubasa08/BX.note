require 'rails_helper'

describe 'ユーザー機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:admin_user) }

  describe '新規登録機能' do
    let(:name) { 'テストユーザー' }
    let(:email) { 'test@mail.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }

    before do
      visit new_user_path
      fill_in 'ユーザー名', with: name
      fill_in 'メールアドレス', with: email
      fill_in 'パスワード', with: password
      fill_in '確認用パスワード', with: password_confirmation
      click_button 'アカウント登録'
    end

    context '必要条件を満たしている' do
      it '正常に登録される' do
        expect(page).to have_selector '.alert--success', text: 'アカウント登録が完了しました。'
      end
    end

    context '全項目が空欄' do
      let(:name) { '' }
      let(:email) { '' }
      let(:password) { '' }
      let(:password_confirmation) { '' }
      it 'エラーになる' do
        expect(page).to have_selector '#error_explanation li', text: '・ユーザー名を入力してください'
        expect(page).to have_selector '#error_explanation li', text: '・メールアドレスを入力してください'
        expect(page).to have_selector '#error_explanation li', text: '・メールアドレスは不正な値です'
        expect(page).to have_selector '#error_explanation li', text: '・メールアドレスはすでに存在します'
        expect(page).to have_selector '#error_explanation li', text: '・パスワードを入力してください'
      end
    end

    context '確認用パスワードがパスワードと異なる' do
      let(:password) { 'password' }
      let(:password_confirmation) { 'foobar' }
      it 'エラーになる' do
        expect(page).to have_selector '#error_explanation li', text: '・確認用パスワードとパスワードの入力が一致しません'
      end
    end

    context 'メールアドレスが既に存在する' do
      let(:email) { other_user.email }
      it 'エラーになる' do
        expect(page).to have_selector '#error_explanation li', text: '・メールアドレスはすでに存在します'
      end
    end
  end


  describe '編集機能' do
    before do
      sign_in_as user
      click_link 'プロフィールを編集'
    end

    context '必要条件を満たしている' do
      before do
        fill_in 'ユーザー名', with: 'テストユーザー編集'
        fill_in 'メールアドレス', with: 'testEdit@mail.com'
        fill_in 'パスワード', with: 'passwordEdit'
        fill_in '確認用パスワード', with: 'passwordEdit'
        click_button '更新する'
      end
      it '正常に登録される' do
        expect(page).to have_content 'プロフィールを更新しました。'
      end
    end
  end

  describe '削除機能' do
    before do
      sign_in_as admin_user
      visit user_path(user)
      click_link '削除'
      page.driver.browser.switch_to.alert.accept
    end
    it '正常に削除される' do
      expect(page).to have_content 'ユーザーを削除しました。'
    end
  end

  describe '詳細ページ' do
    before do
      visit user_path(user)
    end

    it 'ログインしていなくてもユーザー名が表示される' do
      expect(page).to have_selector 'h1', text: user.name
    end

    context 'ログインしている場合' do
      before do
        sign_in_as user
      end

      it 'ログインしているとユーザー編集ページへのリンクも表示される' do
        expect(page).to have_selector 'h1', text: user.name
        expect(page).to have_selector 'a', text: 'プロフィールを編集'
      end
    end
  end
end