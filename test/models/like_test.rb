require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @like = Like.new(post_id: posts(:orange).id, 
                     user_id: users(:archer).id)
  end

  test "正常な関係性" do
    assert @like.valid?
  end

  test "post_idが空" do
    @like.post_id = nil
    assert_not @like.valid?
  end

  test "user_idが空" do
    @like.user_id = nil
    assert_not @like.valid?
  end
end
