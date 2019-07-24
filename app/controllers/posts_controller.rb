class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js {@post}
    end
  end
  

  def create
    require 'nokogiri'
    require 'open-uri'
    
    @post = current_user.posts.build(post_params)
    
    if @post.save

      if @post.genre == 'article'
        url = @post.link_url
        begin
          # リンク先OGP取得
          $doc = Nokogiri::HTML(open(url)) #エラーポイント
          $link_title = $doc.css('meta[property="og:title"]').attribute('content').to_s
          $link_image = $doc.css('meta[property="og:image"]').attribute('content').to_s
          $link_desc = $doc.css('meta[property="og:description"]').attribute('content').to_s
          if $link_title && $link_image && $link_desc # エラーポイントを通れば各metaタグのcontentが空でもtrue
            @post.link_title = $link_title
            @post.link_image = $link_image
            @post.link_desc = $link_desc
            if @post.save
              respond_to do |format|
                format.html { redirect_back(fallback_location: root_url) }
                format.js
              end
            end
          end
        rescue #エラーが発生した場合(正規表現だが存在しないURL)
          @post.destroy
          @e_error = "記事のURLが存在しません。"
          respond_to do |format|
            format.html { redirect_back(fallback_location: root_url) }
            format.js
          end
        end
      else #@post == 'other'
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
      format.js {@post}
    end
  end


  def update 
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)

      if @post.genre == 'article'
        url = @post.link_url
        begin
          # リンク先OGP取得
          $doc = Nokogiri::HTML(open(url)) #エラーポイント
          $link_title = $doc.css('meta[property="og:title"]').attribute('content').to_s
          $link_image = $doc.css('meta[property="og:image"]').attribute('content').to_s
          $link_desc = $doc.css('meta[property="og:description"]').attribute('content').to_s
          if $link_title && $link_image && $link_desc # エラーポイントを通れば各metaタグのcontentが空でもtrue
            @post.link_title = $link_title
            @post.link_image = $link_image
            @post.link_desc = $link_desc
            if @post.save
              respond_to do |format|
                format.html { redirect_back(fallback_location: root_url) }
                format.js
              end
            end
          end
        rescue #エラーが発生した場合(正規表現だが存在しないURL)
          @e_error = "記事のURLが存在しません。"
          respond_to do |format|
            format.html { redirect_back(fallback_location: root_url) }
            format.js
          end
        end
      else #@post == 'other'
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
    params.require(:post).permit(:content, :link_url, :link_title, :link_image, :book_evaluation, :genre, images: [], category_ids: [] ) 
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end