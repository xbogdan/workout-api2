class ChangeDateFormatInTrackDays < ActiveRecord::Migration
  def change
    change_column :track_days, :date, :datetime
  end
end
