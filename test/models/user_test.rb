require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
              password: "foobar", password_confirmation: "foobar", introduce: 'My name is Example')
    @twitter = User.new(name: "Example User", email: "",
              password: "foobar", password_confirmation: "foobar", introduce: '',
              uid: '1', provider: 'provider', image_url: 'test.jpg', )
  end

  # テストユーザー
  test "should be valid" do
    assert @user.valid?
  end

  test "should be valid twitter" do
    assert @twitter.valid?
  end


  # 名前が空
  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "name should be present twitter" do
    @twitter.name = " "
    assert_not @twitter.valid?
  end


  # 名前が51文字以上
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "name should not be too long twitter" do
    @twitter.name = "a" * 51
    assert_not @twitter.valid?
  end


  # 自己紹介が151文字以上
  test "introduce should not be too long" do
    @user.introduce = "a" * 151
    assert_not @user.valid?
  end
  test "introduce should not be too long twitter" do
    @twitter.introduce = "a" * 151
    assert_not @twitter.valid?
  end


  # 自己紹介が空
  test "introduce nil valid" do
    @user.introduce = ""
    assert @user.valid?
  end

  test "introduce nil valid twitter" do
    @twitter.introduce = ""
    assert @twitter.valid?
  end


  # メールアドレスが256文字以上
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  # メールアドレスが空
  test "email nil valid twitter" do
    @twitter.email = ""
    assert @twitter.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US_ER@foo.bar.org
                first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                  foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address| 
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses sould be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test  "email addresses should be saved as lower-case" do
    mixed_case_email =  "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  # パスワードがスペース6個
  test  "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  # パスワードが５文字以下
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "password should have a minimum length twitter" do
    @twitter.password = "a" * 5
    assert_not @twitter.valid?
  end

  test  "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

   test "associated posts should be destroyed" do
      @user.save
      @user.posts.create!(content: "Lorem ipsum", genre: "other")
      assert_difference 'Post.count', -1 do
        @user.destroy
      end
    end

  #   test "should follow and unfollow a user" do
  #     michael = users(:michael)
  #     archer = users(:archer)
  #     assert_not michael.following?(archer)
  #     michael.follow(archer)
  #     assert michael.following?(archer)
  #     assert archer.followers.include?(michael)
  #     michael.unfollow(archer)
  #     assert_not michael.following?(archer)
  #   end

  #   test  "feed should have the right posts" do
  #     michael = users(:michael)
  #     archer = users(:archer)
  #     lana = users(:lana)
  #      # フォローしているユーザーの投稿を確認
  #      lana.microposts.each do |post_following|
  #       assert michael.feed.include?(post_following)
  #      end
  #      # 自分自身の投稿を確認
  #      michael.microposts.each do |post_self|
  #       assert michael.feed.include?(post_self)
  #      end
  #      # フォローしていないユーザーの投稿を確認
  #      archer.microposts.each do |post_unfollowed|
  #       assert_not michael.feed.include?(post_unfollowed)
  #      end
  #   end
end
