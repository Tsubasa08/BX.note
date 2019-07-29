require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = Comment.new(post_id: posts(:orange).id, # (user: michael)
                           user_id: users(:archer).id,
                           content: '乗ります。僕が乗ります。')
  end

  test '正常な関係性' do
    assert @comment.valid?
  end

  test 'post_idが空' do
    @comment.post_id = nil
    assert_not @comment.valid?
  end

  test 'user_idが空' do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test 'contentが空' do
    @comment.content = nil
    assert_not @comment.valid?
  end

  test 'contentが141文字以上' do
    @comment.content = 'a' * 141
    assert_not @comment.valid?
  end
end
