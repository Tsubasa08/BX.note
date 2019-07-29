class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(20)
    @current_page_post = 'current' # ページレイアウト活性化
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = 'アカウント登録が完了しました。'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'プロフィールを更新しました。'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'ユーザーを削除しました。'
    redirect_to root_url
  end

  def following
    @current_page_following = 'current' # ページレイアウト活性化
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(18)
    render 'show_follow'
  end

  def followers
    @current_page_followers = 'current' # ページレイアウト活性化
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(18)
    render 'show_follow'
  end

  def likes
    @user = User.find(params[:id])
    @likes = Like.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(20)
    @current_page_like = 'current' # ページレイアウト活性化
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduce, :image)
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
