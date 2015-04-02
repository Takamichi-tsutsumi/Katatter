class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "An account successfully created!!"
      redirect_to @user
    else
      #flash[:error] = render '/shared/error_messages', object: @user
      redirect_to signup_path, alert: '書式が不適切です。'
    end
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.paginate(page: params[:page], per_page: 10)
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :remember_token, :image, :image_cache, :remove_image)
  end
end
