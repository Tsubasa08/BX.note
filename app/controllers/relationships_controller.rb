class RelationshipsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]
  before_action :logged_in_or_new_account, only: [:create]

  def create
    @user = User.find(params[:followed_id])
    @now_user = User.find(params[:user_page_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    @now_user = User.find(params[:user_page_id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url) }
      format.js
    end
  end


  private

  def logged_in_or_new_account
    unless logged_in?
      store_location
      flash[:danger] = "アカウント登録、もしくはログインしてください。"
      redirect_to new_user_path
    end
  end

end
