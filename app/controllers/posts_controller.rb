class PostsController < ApplicationController
  include GetOgp
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js { @post }
    end
  end

  def create
    require 'nokogiri'
    require 'open-uri'
    @post = current_user.posts.build(post_params)
    if @post.save
      if @post.genre == 'article'
        get_ogp
      else
        respond_to do |format|
          format.html { redirect_back(fallback_location: root_url) }
          format.js
        end
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_url) }
        format.js
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js { @post }
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      if @post.genre == 'article'
        get_ogp
      else
        respond_to do |format|
          format.html { redirect_back(fallback_location: root_url) }
          format.js
        end
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_url) }
        format.js
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js
    end
  end

  

  private

  def post_params
    params.require(:post).permit(:content, :link_url, :link_title, :link_image, :book_evaluation, :genre, images: [], category_ids: [])
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
