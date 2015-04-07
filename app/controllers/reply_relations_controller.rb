class ReplyRelationsController < ApplicationController
  before_action :signed_in_user

  def new
    @replied_tweet = Tweet.find(params[:tweet_id])
    @reply_tweet = Tweet.new
  end

  def create
    @reply_tweet = current_user.tweets.build(tweet_params)
    if @reply_tweet.save?
      @replied_tweet = Tweet.find(params[:tweet_id])
      @reply_tweet.reply!(@replied_tweet)
      redirect_to(:back)
    else
      @reply_tweet = []
      render 'root_path'
    end
  end

end
