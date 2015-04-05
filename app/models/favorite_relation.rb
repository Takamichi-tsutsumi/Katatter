class FavoriteRelation < ActiveRecord::Base
  belongs_to :user_favorite, class_name: "User"
  belongs_to :favorite_tweet, class_name: "Tweet"
  validates :user_favorite_id, presence: true
  validates :favorite_tweet_id, presence: true
end
