class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @id = @category.id
    # @posts = @category.post_categories
    # @posts = Post_Categories.where(category_id: @id)
    # @posts = @category.post_categories.build
     @category.post_categories.each do |po| 
       @posts = po.post
     end 
    #  @posts = @category.post_categories
    # @posts = current_user.posts.build if logged_in?
  end
end
