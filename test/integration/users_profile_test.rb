require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
   include ApplicationHelper

  def setup
  @user = users(:michael)
  @other_user = users(:archer)
  end

  # Userプロフィール画面に対するテスト
  test "自分のプロフィールページ" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'img#profile-block__img--show'
    assert_match @user.posts.count.to_s, response.body
    assert_select "a[class=post-edit]", text: "編集する" 
    assert_select "a[href=?]", "#{edit_user_path(@user)}", text: "プロフィールを編集" 

    assert_select "li.ProfileNav-list__item" do
      assert_select "a.link--post-page" do
        assert_select "span[class=link__num]", text: "#{@user.posts.count}"
      end
      assert_select "a.link--following" do
        assert_select "span[class=following]", text: "#{@user.active_relationships.count}"
      end
      assert_select "a.link--followers" do
        assert_select "span[class=followers]", text: "#{@user.passive_relationships.count}"
      end
      assert_select "a.link--likes" do
        assert_select "span[class=link__num]", text: "#{@user.likes.count}"
      end
    end
    # assert_select 'div.pagination', count: 1
    # @user.posts.paginate(page: 1).each do |post|
    #   assert_match post.content, response.body
    # end
  end

  test "他人のプロフィールページ" do
    log_in_as(@user)
    get user_path(@other_user)
    assert_template 'users/show'
    assert_select "a[class=post-edit]", text: "編集する", count: 0
    assert_select "a[href=?]", "#{edit_user_path(@user)}", text: "プロフィールを編集", count: 0

    assert_select "li.ProfileNav-list__item" do
      assert_select "a.link--post-page" do
        assert_select "span[class=link__num]", text: "#{@other_user.posts.count}"
      end
      assert_select "a.link--following" do
        assert_select "span[class=following]", text: "#{@other_user.active_relationships.count}"
      end
      assert_select "a.link--followers" do
        assert_select "span[class=followers]", text: "#{@other_user.passive_relationships.count}"
      end
      assert_select "a.link--likes" do
        assert_select "span[class=link__num]", text: "#{@other_user.likes.count}"
      end
    end
  end

end
