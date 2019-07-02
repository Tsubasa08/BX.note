class UsersController < ApplicationController
before_action :logged_in_user, only: [:edit, :update, :destroy, :following, :followers]
before_action :correct_user, only: [:edit, :update]
# before_action :admin_user, only: :destroy

  # def index
  #   # @users = User.where(activated: true).paginate(page: params[:page]) #ページネーション
  # end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(20)
    # @post = current_user.posts.build if logged_in?
    redirect_to(root_url) unless current_user?(@user) 
  end
  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = "アカウント登録が完了しました。"
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
      flash[:success] = "プロフィールを更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
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
  # def admin_user
  #   redirect_to(root_url) unless current_user.admin?
  # end

  
end
