class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Post.find(params[:post_id])
    # @post = Post.find(id: post.id])
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
    # @post = Like.find(params[:id]).post
    if @post.like?(current_user)
      @post.unlike(current_user)
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_url) }
        format.js
      end
    end
  end
end
