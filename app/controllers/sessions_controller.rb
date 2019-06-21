class SessionsController < ApplicationController
  def new
  end
  
  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
      log_in (@user)
      # redirect_back_or user
      redirect_to @user
    else 
      @user = User.find_by(email: params[:session][:email].downcase)
      if @user && @user.authenticate(params[:session][:password])
        log_in (@user)
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        # redirect_back_or @user
        redirect_to @user
      else
        flash.now[:danger] =  'メーアドレスもしくはパスワードが正しくありません' 
        render 'new'
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
