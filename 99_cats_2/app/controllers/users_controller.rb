class UsersController < ApplicationController

  before_action :require_logged_in, except: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    debugger
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by(params[:id])
    if @user
      render :show
    else
      redirect_to :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password) ## Not sure if password, password_digest OR SOMETHING ELSE
  end
end

  