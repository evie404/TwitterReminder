class CreateRateWatchers < ActiveRecord::Migration
  def change
    create_table :rate_watchers do |t|
      t.references :user

      t.timestamps
    end
    add_index :rate_watchers, :user_id
  end
end
