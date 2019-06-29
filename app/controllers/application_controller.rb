class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  include SessionsHelper
  before_action :set_category

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
