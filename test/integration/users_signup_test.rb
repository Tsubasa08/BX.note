require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  # 不正なアカウントでログイン
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: '',
                                          email: 'user@invalid',
                                          password: 'foo',
                                          password_confirmation: 'bar' } }
    end
    assert_template 'users/new'
    assert_select 'li.error-list__item', '・ユーザー名を入力してください'
    assert_select 'li.error-list__item', '・メールアドレスは不正な値です'
    assert_select 'li.error-list__item', '・パスワードは6文字以上で入力してください'
    assert_select 'li.error-list__item', '・確認用パスワードとパスワードの入力が一致しません'
    assert_select 'form[action="/signup"]'
  end

  # 正当なアカウントでログイン
  test 'valid signup information with account activation' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Example User',
                                         email: 'user@example.com',
                                         password: 'password',
                                         password_confirmation: 'password' } }
    end
    user = assigns(:user)
    # 有効化していない状態でログイン
    log_in_as(user)
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert_select 'div.alert--success'
    assert is_logged_in?
  end
end
