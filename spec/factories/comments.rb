FactoryBot.define do
  factory :comment do
    content { 'テストコメント' }
    user
    # post
    association :post, factory: :other_post
  end
end