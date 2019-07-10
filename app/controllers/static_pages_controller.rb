class StaticPagesController < ApplicationController
  def top
    # @post = current_user.posts.build if logged_in?
    @posts = Post.all.page(params[:page]).per(20)
    # @q = Post.ransack(params[:q])
    # @posts = @q.result(distinct: true).page(params[:page]).per(20)
  end

  

  def about
  end

  def terms
  end

  def policy
  end
end
