class UsersController < ApplicationController
  before_action :set_user, :check_current_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).page params[:page]
    @followings = @user.following_users.page params[:page]
    @followers = @user.follower_users.page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "プロフィールを編集しました。"
    else
      render 'edit'
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.following_users.page params[:page]
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.follower_users.page params[:page]
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :region, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_current_user
    if params[:id].to_i != session[:user_id]
      redirect_to root_path, notice: "不正な操作です。"
    end
  end
end
