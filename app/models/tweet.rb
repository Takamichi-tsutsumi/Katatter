class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :reverse_favorite_relations, foreign_key: "favorite_tweet_id", class_name: "FavoriteRelation", dependent: :destroy
  has_many :user_favorites, through: :reverse_favorite_relations, source: :user_favorite

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
end
