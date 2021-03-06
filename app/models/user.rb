class User < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :favorite_relations, foreign_key: "user_favorite_id", dependent: :destroy
  has_many :favorite_tweets, through: :favorite_relations, source: :favorite_tweet

  before_save { self.email = email.downcase}
  before_create :create_remember_token

  mount_uploader :image, ImageUploader

  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: VALID_EMAIL_REGEX }

  has_secure_password

  validates :password,
    length: { minimum: 6 }

  VALID_USERID_REGEX = /\A@[0-9a-z]+\z/

  validates :userid,
    presence: true,
    uniqueness: true,
    format: { with:  VALID_USERID_REGEX }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def feed
    Tweet.from_users_followed_by(self)
  end

  def favorite!(tweet)
    favorite_relations.create!(favorite_tweet_id: tweet.id)
  end

  def unfavorite!(tweet)
    favorite_relations.find_by(favorite_tweet_id: tweet.id).destroy
  end

  def favorite?(tweet)
    favorite_relations.find_by(favorite_tweet_id: tweet.id)
  end


  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
