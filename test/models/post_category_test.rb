require 'test_helper'

class PostCategoryTest < ActiveSupport::TestCase
  
  def setup
    @post_category = PostCategory.new(post_id: posts(:orange).id, 
                                       category_id: categories(:html).id)
  end

  test "有効なテストデータ" do
    assert @post_category.valid?
  end

  test "post_idが空" do
    @post_category.post_id = nil
    assert_not @post_category.valid?
  end

  test "category_idが空" do
    @post_category.category_id = nil
    assert_not @post_category.valid?
  end

end
