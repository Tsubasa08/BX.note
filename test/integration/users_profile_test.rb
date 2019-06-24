require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
   include ApplicationHelper

  def setup
  @user = users(:michael)
  end

  # Userプロフィール画面に対するテスト
  test "profile display" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'img#profile-block__img--show'
    assert_match @user.posts.count.to_s, response.body
    # assert_select 'div.pagination', count: 1
    # @user.posts.paginate(page: 1).each do |post|
    #   assert_match post.content, response.body
    # end
    # assert_match @user.active_relationships.count.to_s, response.body
    # assert_match @user.passive_relationships.count.to_s, response.body
  end

end
