require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:michael)
    remember(@user)
  end

  test "current_userとセッションを永続的にさせたユーザーを比較" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "記憶ダイジェストが記憶トークンと正しく対応していない" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end

end