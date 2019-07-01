class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def create
    require 'nokogiri'
    require 'open-uri'
    # @url = params[:article_url]

    # url = "https://www.amazon.co.jp/s?k=#{@url}&__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&ref=nb_sb_noss_2"
    # url = @url

    # $doc = Nokogiri::HTML(open(url))
    # $data = $doc.css('meta[name="description"]').attribute('content').to_s
    
    @post = current_user.posts.build(post_params)
    
    # url = current_user.posts.build(post_params_url)
    # url = "https://www.amazon.co.jp/gp/product/4797393157?pf_rd_p=3d322af3-60ce-4778-b834-9b7ade73f617&pf_rd_r=S7C9AJF041GHQNYKPSDP"
    # url = @url

    # charset = nil
    # html = open(url) do |f|
    #   charset = f.charset #文字種別を取得します。
    #   f.read ＃htmlを読み込み変数htmlに渡します。
    # end

    # $doc = Nokogiri::HTML.parse(html, nil, charset)
    

    # @post.book_title = $data

    if @post.save
      flash[:success] = "投稿を送信しました。"

      # リンク先OGP取得
      # if @post.genre == 'article'
      unless @post.genre == 'other'
        url = @post.link_url
        $doc = Nokogiri::HTML(open(url))
        $link_title = $doc.css('meta[property="og:title"]').attribute('content').to_s
        $link_image = $doc.css('meta[property="og:image"]').attribute('content').to_s
        $link_desc = $doc.css('meta[property="og:description"]').attribute('content').to_s
        @post.link_title = $link_title
        @post.link_image = $link_image
        @post.link_desc = $link_desc
        @post.save        
      end

      # redirect_to root_url
      redirect_back(fallback_location: root_url)
    else
      # @feed_items = []
      flash[:danger] = "投稿失敗"
      redirect_back(fallback_location: root_url)
    end
  end

  def ajax
    render json: @user
  end


  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました。"
    # 1つ前のURLに戻る
    redirect_back(fallback_location: root_url)
  end

  private

  def post_params
    params.require(:post).permit(:content, :link_url, :book_evaluation, :genre, images: [], category_ids: [] ) 
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end

def get_host(path)
  host = path.sub(/\\/, '/').match(/\/\/([^\/]*)/)
  # '' if !host
  host[1]
end
