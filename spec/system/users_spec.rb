require 'rails_helper'

describe 'ユーザー機能', type: :system do

  describe '新規作成機能' do
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
      # before do
      # end
      FactoryBot.create(:kaeru)
      let(:email) { 'kaeru@mail.com' }
      it 'エラーになる' do
        expect(page).to have_selector '#error_explanation li', text: '・メールアドレスはすでに存在します'
      end
    end
  end
end