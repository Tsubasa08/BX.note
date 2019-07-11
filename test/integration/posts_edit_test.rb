require 'test_helper'

class PostsEditTest < ActionDispatch::IntegrationTest

  def setup
     @post = posts(:orange) #user: michael
     @article_post = posts(:potato)
     @user = users(:michael)
     @other_user = users(:archer)
   end

  test  "successful edit" do
    log_in_as(@user)
    get user_path(@user)
    assert_select "a[class=post-edit]", text: "編集する"    
    assert_select "a[class=post-edit]", href: "#{edit_post_path(@post.id)}"
    get edit_post_path(@post), xhr: true
    assert_response :success
    content = "鳴らない電話"
    # image = fixture_file_upload('test/fixtures/Apple.jpg', 'image/jpg')
    category = [4, 5]
    # category_ids: []
    # genreは隠しinputで入力済み
    patch post_path(@post), params: { post: { content: content, image: ""},
                                      category_ids: category}
    @post.category_ids = category
    assert_not flash.empty?
    # assert_redirected_to @user
    @post.reload
    assert_equal content, @post.content
    assert_equal category, @post.category_ids
  end

end
