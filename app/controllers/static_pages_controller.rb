class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @user = current_user
      @tweet = current_user.tweets.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
end
