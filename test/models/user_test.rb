require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
              password: "foobar", password_confirmation: "foobar", introduce: 'My name is Example')
    @twitter = User.new(name: "Example User", email: "",
              password: "foobar", password_confirmation: "foobar", introduce: '',
              uid: '1', provider: 'provider', image_url: 'test.jpg', )
  end

  test "正常なユーザー" do
    assert @user.valid?
  end

  test "正常なユーザー(Twitter認証)" do
    assert @twitter.valid?
  end


  test "名前が空" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "名前が空(Twitter認証)" do
    @twitter.name = " "
    assert_not @twitter.valid?
  end


  test "名前が51文字以上" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "名前が51文字以上(Twitter経由)" do
    @twitter.name = "a" * 51
    assert_not @twitter.valid?
  end


  test "自己紹介が151文字以上" do
    @user.introduce = "a" * 151
    assert_not @user.valid?
  end
  test "自己紹介が151文字以上(Twitter経由)" do
    @twitter.introduce = "a" * 151
    assert_not @twitter.valid?
  end


  test "自己紹介が空" do
    @user.introduce = ""
    assert @user.valid?
  end

  test "自己紹介が空(Twitter経由)" do
    @twitter.introduce = ""
    assert @twitter.valid?
  end


  test "メールアドレスが256文字以上" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "メールアドレスが空" do
    @twitter.email = ""
    assert @twitter.valid?
  end

  test "メールアドレスが正しい正規表現" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US_ER@foo.bar.org
                first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "メールアドレスが不正な正規表現" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                  foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address| 
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "メールアドレスが一意ではない" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test  "メールアドレスに大文字が含まれる" do
    mixed_case_email =  "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test  "パスワードがスペース6個" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "パスワードが５文字以下" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "パスワードが５文字以下(Twitter経由)" do
    @twitter.password = "a" * 5
    assert_not @twitter.valid?
  end

  test  "ダイジェストが空" do
    assert_not @user.authenticated?(:remember, '')
  end

   test "ユーザー削除時の投稿データ" do
      @user.save
      @user.posts.create!(content: "Lorem ipsum", genre: "other")
      assert_difference 'Post.count', -1 do
        @user.destroy
      end
    end

    test "フォロー/フォロー解除" do
      michael = users(:michael)
      archer = users(:archer)
      assert_not michael.following?(archer)
      michael.follow(archer)
      assert michael.following?(archer)
      assert archer.followers.include?(michael)
      michael.unfollow(archer)
      assert_not michael.following?(archer)
    end

end
