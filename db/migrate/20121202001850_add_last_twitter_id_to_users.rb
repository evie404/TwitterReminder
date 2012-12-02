class AddLastTwitterIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_tweet_id, :integer, :limit => 8
  end
end
