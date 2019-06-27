require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @category = categories(:html)
  end

  test "カテゴリーページへアクセス" do
    get category_path(@category)
    assert_response :success
  end
end
