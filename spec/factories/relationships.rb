FactoryBot.define do
  factory :relationship do
    # association :user
    association :follower, factory: :user
    association :followed, factory: :other_user
  end
end