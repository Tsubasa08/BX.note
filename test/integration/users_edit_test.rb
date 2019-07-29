require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test '正常なユーザープロフィール編集' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Foo Bar'
    email = 'foo@bar.com'
    introduce = 'My name is Foo Bar'
    image = fixture_file_upload('test/fixtures/Apple.jpg', 'image/jpg')
    patch user_path(@user), params: { user: { name: name, email: email,
                                              password: '', password_confirmation: '',
                                              introduce: introduce, image: image } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test '不正なユーザープロフィール編集' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: '', email: 'foo@invalid',
                                              password: 'foo', password_confirmation: 'bar',
                                              introduce: 'a' * 151 } }
    assert_template 'users/edit'
    assert_select '.error-list__item', count: 5
  end

  test 'フレンドリーフォワーディング機能(ログイン前にユーザープロフィール編集ページへアクセス)' do
    get edit_user_path(@user)
    assert_equal edit_user_url(@user), session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name = 'Foo Bar'
    email = 'foo@bar.com'
    patch user_path(@user), params: { user: { name: name, email: email, password: '', password_confirmation: '' } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
