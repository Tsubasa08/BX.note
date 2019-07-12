require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "アカウント登録ページへアクセス" do
    get signup_path
    assert_response :success
  end

  test "editページへアクセス ログインなし" do
    get edit_user_path(@user) #HTTPリクエスト：get
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "updateアクション ログインなし" do
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } } #HTTPリクエスト：patch
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "editページへアクセス 異なるユーザー" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "updateアクション 異なるユーザー" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "admin属性の変更" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: { password: @other_user.password, 
                                                    password_confirmation: @other_user.password,
                                                    admin: true} }
    assert_not @other_user.reload.admin?
  end

  test "destroyアクスション ログインなし" do
    assert_no_difference 'User.count' do
     delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "destroyアクスション admin属性:false" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "destroyアクスション admin属性:true" do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end



end
