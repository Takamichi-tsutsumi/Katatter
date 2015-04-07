class ReplyRelation < ActiveRecord::Base
  belongs_to :replied_tweet, class_name: "Tweet"
  belongs_to :reply_tweet, class_name: "Tweet"
  validates :replied_tweet_id, presence: true
  validates :reply_tweet_id, presence: true
end
