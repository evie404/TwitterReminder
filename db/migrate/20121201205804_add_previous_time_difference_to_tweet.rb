class AddPreviousTimeDifferenceToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :previous_time_difference, :integer
  end
end
