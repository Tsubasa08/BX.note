class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    postsNumber = 20
    @posts = @category.posts.page(params[:page]).per(postsNumber)
  end
end
