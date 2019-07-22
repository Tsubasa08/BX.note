require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  
  test "ログインしていないユーザーでフォロー" do
    assert_no_difference 'Relationship.count' do
      post relationships_path
    end
    assert_redirected_to new_user_path
  end

  test "ログインしていないユーザーでフォロー解除" do
    assert_no_difference 'Relationship.count' do
      delete relationship_path(relationships(:one))
    end
    assert_redirected_to login_url
  end

end
