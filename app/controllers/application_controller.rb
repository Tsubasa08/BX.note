class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  include SessionsHelper
  before_action :set_category
  before_action :search

  def set_category
    @categories = Category.all
  end

  def select
    @genre = params[:data]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def search_book
    require 'nokogiri'
    require 'open-uri'
    require 'uri'

    @data = params[:content]
    url = URI.encode("https://www.amazon.co.jp/s?k=#{@data}&__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&ref=nb_sb_noss_2")
    $doc = Nokogiri::HTML(open(url))
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js 
    end
  end

  def search
    @q = Post.ransack(params[:q])
    @search_posts = @q.result(distinct: true).page(params[:page]).per(20)
  end

  private
  # ユーザーのログインを確認する
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
end
