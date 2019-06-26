class StaticPagesController < ApplicationController
  def top
    @post = current_user.posts.build if logged_in?
    @categories = Category.all
  end

  def about
  end

  def terms
  end

  def policy
  end
end
