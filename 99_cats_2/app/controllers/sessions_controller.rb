class SessionsController < ApplicationController

  before_action :require_logged_in, except: [:new, :create] ## Is this correct? WHO KNOWS

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user
      login!(@user)
      redirect_to users_url(@user) #unsure about which route(user_url OR users/url) but I think we got it fam :)
    else
      flash.now[:errors] = ["Invalid Credentials"]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token! if current_user
    session[:session_token] = nil 

    @current_user = nil
  end
end
