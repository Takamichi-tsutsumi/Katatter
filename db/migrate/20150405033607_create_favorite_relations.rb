class CreateFavoriteRelations < ActiveRecord::Migration
  def change
    create_table :favorite_relations do |t|
      t.integer :user_favorite_id
      t.integer :favorite_tweet_id

      t.timestamps null: false
    end
    add_index :favorite_relations, :user_favorite_id
    add_index :favorite_relations, :favorite_tweet_id
    add_index :favorite_relations, [:user_favorite_id, :favorite_tweet_id], unique: true
  end
end
