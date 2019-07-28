FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    sequence(:email) { |n| "test#{n}@mail.com" }
    # email { 'test@mail.com' }
    password { 'password' }
    admin { false }
  end

  factory :kaeru, class: User do
    name { 'カエル' }
    email { 'kaeru@mail.com' }
    password { 'password' }
    admin { false }
  end

  factory :tokage, class: User do
    name { 'トカゲ' }
    email { 'tokage@mail.com' }
    password { 'password' }
    admin { false }
  end

  factory :tokagegg, class: User do
    name { 'トカゲg' }
    email { 'tokagegg@mail.com' }
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
end