class AddDateToTrackDay < ActiveRecord::Migration
  def change
    add_column :track_days, :date, :date
  end
end
