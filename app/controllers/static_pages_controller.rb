class StaticPagesController < ApplicationController
  def top
    postsNumber = 20
    @posts = Post.all.page(params[:page]).per(postsNumber)
  end

  def about; end

  def terms; end

  def policy; end
end
