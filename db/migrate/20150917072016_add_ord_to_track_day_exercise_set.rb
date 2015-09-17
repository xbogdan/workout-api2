class AddOrdToTrackDayExerciseSet < ActiveRecord::Migration
  def change
    add_column :track_day_exercise_sets, :ord, :integer
  end
end
