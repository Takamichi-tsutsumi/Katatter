class UsersController < ApplicationController
  before_action :admin_user, only: :destroy
  before_action :signed_in_user, only: :edit

  def new
    @user = User.new
  end

  def index
    @search = User.search(params[:q])
    @users = @search.result.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "An account successfully created!!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.paginate(page: params[:page], per_page: 10)
    # @feed_items = @user.feed.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "フォローしてるユーザー"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title ="フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def favorites
    @title = "お気に入り"
    @user = User.find(params[:id])
    @tweets = @user.favorite_tweets.paginate(page: params[:page])
    render 'show_favorites'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :userid, :password, :password_confirmation, :image, :image_cache, :remove_image)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
