class FavoriteRelationsController < ApplicationController
  before_action :signed_in_user

  def create
    @tweet = Tweet.find(params[:favorite_relation][:favorite_tweet_id])
    @user = current_user
    @user.favorite!(@tweet)
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js
    end
  end

  def destroy
    @tweet = FavoriteRelation.find_by(params[:id]).favorite_tweet
    @user = current_user
    current_user.unfavorite!(@tweet)
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js
    end
  end

end
