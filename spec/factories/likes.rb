FactoryBot.define do
  factory :like do
    association :user, factory: :user
    association :post, factory: :other_post
  end
end