class StaticPagesController < ApplicationController
  def top
    @posts = Post.all.page(params[:page]).per(20)
  end

  def about; end

  def terms; end

  def policy; end
end
