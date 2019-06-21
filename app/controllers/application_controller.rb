class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  include SessionsHelper
  # protect_from_forgery with: :exception, prepend: true
  private
  # ユーザーのログインを確認する
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end
end
