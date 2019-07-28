require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe 'ユーザーが有効' do

    context '通常のユーザー' do
      it '有効であること' do
        expect(user).to be_valid
      end
    end

    context 'Twitter認証によるユーザー' do
      let(:user) { FactoryBot.create(:twitter_user) }
      it '有効であること' do
        expect(user).to be_valid
      end
    end

    it '保存される前にメールアドレスに含まれる大文字が小文字に変換されること' do
      user.email = 'Foo@ExAMPle.CoM'
      user.save
      expect(user.email).to eq 'foo@example.com'
    end

  end


  describe 'ユーザーが無効' do

    context 'ユーザー名に対するvalidation' do
      it 'ユーザー名が存在しない場合無効であること' do
        user.name = ''
        expect(user).to_not be_valid
      end

      it 'ユーザー名が30文字以上の場合無効であること' do
        user.name = 'a' * 31
        expect(user).to_not be_valid
      end
    end

    context 'メールアドレスに対するvalidation' do
      it 'メールアドレスが存在しない場合無効であること' do
        user.email = ''
        expect(user).to_not be_valid
      end

      it 'メールアドレスが255文字以上の場合無効であること' do
        user.email = 'a' * 247 + '@mail.com'
        expect(user).to_not be_valid
      end

      it 'メールアドレスが既に存在している場合無効であること' do
        # user.email = 'kaeru@mail.com'
        user.email = other_user.email
        expect(user).to_not be_valid
      end

      
      it 'メールアドレスが不正な正規表現の場合無効であること' do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. @bar_baz.com foo@bar+baz.com foo@bar..com]
        invalid_addresses.each do |address| 
          user.email = address
          expect(user).to_not be_valid
        end
      end
    end

    context 'パスワードに対するvalidation' do
      it 'パスワードが存在しない場合無効であること' do
        user.password = nil
        expect(user).to_not be_valid
      end

      it 'パスワードが5文字以内の場合無効であること' do
        user.password = 'a' * 5
        expect(user).to_not be_valid
      end

      it 'パスワードがスペース6個の場合無効であること' do
        user.password = ' ' * 6
        expect(user).to_not be_valid
      end
    end

    context '自己紹介に対するvalidation' do
      it '自己紹介が151文字以上の場合無効であること' do
        user.introduce = 'a' * 151
      end
    end
  end
end