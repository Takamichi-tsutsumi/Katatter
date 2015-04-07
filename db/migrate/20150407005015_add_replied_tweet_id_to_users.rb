class AddRepliedTweetIdToUsers < ActiveRecord::Migration
  def change
    add_column :tweets, :replied_tweet_id, :integer
    add_index :tweets, :replied_tweet_id
  end
end
