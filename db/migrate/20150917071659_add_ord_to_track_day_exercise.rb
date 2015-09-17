class AddOrdToTrackDayExercise < ActiveRecord::Migration
  def change
    add_column :track_day_exercises, :ord, :integer
  end
end
