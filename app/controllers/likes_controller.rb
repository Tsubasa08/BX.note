class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Post.find(params[:post_id])
    unless @post.like?(current_user)
      @post.like(current_user)
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_url) }
        format.js
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    if @post.like?(current_user)
      @post.unlike(current_user)
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_url) }
        format.js
      end
    end
  end
end
