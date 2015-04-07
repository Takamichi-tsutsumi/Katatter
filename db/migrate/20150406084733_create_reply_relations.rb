class CreateReplyRelations < ActiveRecord::Migration
  def change
    create_table :reply_relations do |t|
      t.integer :replied_tweet_id
      t.integer :reply_tweet_id

      t.timestamps null: false
    end
    add_index :reply_relations, :replied_tweet_id
    add_index :reply_relations, :reply_tweet_id
  end
end
