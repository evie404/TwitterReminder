class AddCummlativeTimeDifferenceToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :cummlative_time_difference, :integer, default: 0
  end
end
