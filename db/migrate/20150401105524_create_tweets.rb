class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tubuyaki
      t.integer :user_id
      t.integer :fav_count
      t.integer :ret_count

      t.timestamps null: false
    end
  end
end
