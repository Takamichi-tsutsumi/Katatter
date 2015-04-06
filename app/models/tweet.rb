class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :reverse_favorite_relations, foreign_key: "favorite_tweet_id", class_name: "FavoriteRelation", dependent: :destroy
  has_many :user_favorites, through: :reverse_favorite_relations, source: :user_favorite
  has_many :reply_relations, foreign_key: "replied_tweet_id", dependent: :destroy
  has_many :replied_tweets, through: :reply_relations, class_name: "Tweet", source: :replied_tweet
  has_many :reverse_reply_relations, foreign_key: "reply_tweet_id", class_name: "ReplyRelation", dependent: :destroy
  has_many :reply_tweets, through: :reverse_reply_relations, class_name: "Tweet", source: :reply_tweet

  accepts_nested_attributes_for :reply_relations

  default_scope -> { order('created_at DESC') }

  mount_uploader :image

  validates  :tubuyaki,
    length: { maximum: 255 },
    presence: true

  validates :user_id,
    presence: true

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  end

  def reply!(other_tweet)
    reply_relations.create!( replied_tweet_id: other_tweet.id )
  end
end
