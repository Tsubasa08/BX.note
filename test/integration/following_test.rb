require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other = users(:archer)
    log_in_as(@user)
  end

  test "フォローページ" do
    get following_user_path(@user)
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "フォロワーページ" do
    get followers_user_path(@user)
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  # 普通の通信とAjax通信に分けてテスト
   test "フォロー機能(普通の通信)" do
    assert_difference '@user.following.count', 1 do
      post relationships_path, params: { followed_id: @other.id }
    end
  end

  test "フォロー機能(Ajax通信)" do
    assert_difference '@user.following.count', 1 do
      post relationships_path, xhr: true, params: { followed_id: @other.id }
    end
  end

  test "フォロー解除機能(普通の通信)" do
    @user.follow(@other)
    relationship = @user.active_relationships.find_by(followed_id: @other.id)
    assert_difference '@user.following.count', -1 do
      delete relationship_path(relationship)
    end
  end

  test "フォロー解除機能(Ajax通信)" do
    @user.follow(@other)
    relationship = @user.active_relationships.find_by(followed_id: @other.id)
    assert_difference '@user.following.count', -1 do
      delete relationship_path(relationship), xhr: true
    end
  end

  test "フォロー数カウント" do
    post relationships_path, params: { followed_id: @other.id }    
    get user_path(@user)
    assert_select "span[class=?]", "following", text: "#{@user.following.count}"
    assert_select "span[class=?]", "followers", text: "#{@user.followers.count}"
    get root_path
    assert_select "span[class=?]", "following", text: "#{@user.following.count}"
    assert_select "span[class=?]", "followers", text: "#{@user.followers.count}"
    # ログインしていないユーザー
    delete logout_path
    get user_path(@user)
    assert_select "span[class=?]", "following", text: "#{@user.following.count}"
    assert_select "span[class=?]", "followers", text: "#{@user.followers.count}"
    # 他のユーザー
    log_in_as(@other)
    get user_path(@user)
    assert_select "span[class=?]", "following", text: "#{@user.following.count}"
    assert_select "span[class=?]", "followers", text: "#{@user.followers.count}"
  end


end