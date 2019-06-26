class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿を送信しました。"
      # redirect_to root_url
      redirect_back(fallback_location: root_url)
    else
      @feed_items = []
      render 'static_pages/top'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました。"
    # 1つ前のURLに戻る
    redirect_back(fallback_location: root_url)
  end

  def html
    
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :article_url, :book_title, :book_evaluation, category_ids: [] ) 
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
