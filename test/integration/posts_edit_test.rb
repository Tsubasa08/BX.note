require 'test_helper'

class PostsEditTest < ActionDispatch::IntegrationTest

  def setup
     @post = posts(:orange) #user: michael
     @article_post = posts(:potato)
     @user = users(:michael)
     @other_user = users(:archer)
   end

  test  "正常な投稿編集" do
    log_in_as(@user)
    get user_path(@user)
    assert_select "a[class=post-edit]", text: "編集する"    
    assert_select "a[class=post-edit]", href: "#{edit_post_path(@post.id)}"
    get edit_post_path(@post), xhr: true
    assert_response :success
    content = "鳴らない電話"
    category = [4, 5]
    # genreは隠しinputで入力済み
    patch post_path(@post), params: { post: { content: content, image: ""}, category_ids: category}, xhr: true
    @post.category_ids = category
    @post.reload
    assert_equal content, @post.content
    assert_equal category, @post.category_ids
  end

end
