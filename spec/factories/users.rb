FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    sequence(:email) { |n| "test#{n}@mail.com" }
    # email { 'test@mail.com' }
    password { 'password' }
    admin { false }
  end

  factory :twitter_user, class: User do
    name { 'Twitter認証ユーザー' }
    password { 'password' }
    uid { 1 }
    provider { 'provider' }
    image_url { 'test.jpg' }
  end

  factory :admin_user, class: User do
    name { '管理者ユーザー' }
    email { 'adomin@mail.com' }
    password { 'password' }
    admin { true }
  end

  factory :kaeru, class: User do
    name { 'カエル' }
    email { 'kaeru@mail.com' }
    password { 'password' }
    admin { false }
  end
end