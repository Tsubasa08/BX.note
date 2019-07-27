FactoryBot.define do
  factory :other_post, class: Post do
    content { 'テストです。' }
    genre { 'other' }
    user
  end

  factory :article_post, class: Post do
    content { 'テストです。' }
    genre { 'article' }
    link_url { 'https://qiita.com/' }
    user
  end

  factory :book_post, class: Post do
    content { 'テストです。' }
    genre { 'book' }
    link_url { 'https://qiita.com/' }
    book_evaluation { 5 }
    user
  end
end