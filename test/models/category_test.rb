require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # has_many :post_categories
  # has_many :posts, through: :post_categories

  def setup
    @category = Category.new(name: 'HTML')
    Category.new(name: 'test')
  end

  test "テストカテゴリーデータ" do
    assert @category.valid?
  end

  test "DBカウント" do
    assert_equal 7, Category.count
  end

  test "contentが21文字以上" do
    @category.name = "a" * 21
    assert_not @category.valid?
  end
end
