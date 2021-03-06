class TweetsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @user = current_user
    @tweet = @user.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = "Tweeted!"
      redirect_to(:back)
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @tweet.destroy
    redirect_to root_url
  end

  def index
    @search = Tweet.search(params[:q])
    @tweets = @search.result.paginate(params[:page])
    respond_to do |format|
      format.html
      format.json { render json: @topics }
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @reply_tweets = Tweet.reorder(created_at: :asc).where(replied_tweet_id: params[:id])
  end

  def favorites
    @title = "お気に入りしたユーザー"
    @tweet = Tweet.find(params[:id])
    @users = @tweet.user_favorites.paginate(params[:page])
  end

  def  reply
    @tweet = Tweet.find(params[:id])
    @reply_tweets = Tweet.reorder(created_at: :asc).where(replied_tweet_id: params[:id])
    @tweet = Tweet.new
  end


  private

  def tweet_params
    params.require(:tweet).permit(:tubuyaki, :id, :user_id, :image, :image_cache, :remove_image, :replied_tweet_id)
  end

  def correct_user
    @tweet = current_user.tweets.find_by(id: params[:id])
    redirect_to root_url if @tweet.nil?
  end
end
