require 'test_helper'

class UsersDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
    @other_user = users(:lana)
  end

  test "管理者ユーザー" do
    log_in_as(@admin)
    get user_path(@other_user)
    assert_template 'users/show'
    # assert_select 'div.pagination'
    # first_page_of_users = User.paginate(page: 1)
    assert_select 'a[href=?]', user_path(@other_user), text: '削除'
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
    assert_redirected_to root_url
  end

  test "管理者ユーザーではない" do
    log_in_as(@non_admin)
    get user_path(@other_user)
    assert_template 'users/show'
    assert_select 'a[href=?]', user_path(@other_user), text: '削除', count: 0
    assert_no_difference 'User.count' do
      delete user_path(@other_user)
    end
    assert_redirected_to root_url
  end

end
