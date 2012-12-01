class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :user
      t.integer :twitter_id, :limit => 8

      t.timestamps
    end
    add_index :tweets, :user_id
    add_index :tweets, :twitter_id, :unique => true
  end
end
