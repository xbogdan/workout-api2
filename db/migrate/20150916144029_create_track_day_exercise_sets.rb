class CreateTrackDayExerciseSets < ActiveRecord::Migration
  def change
    create_table :track_day_exercise_sets do |t|
      t.integer :track_day_exercise_id
      t.integer :reps
      t.float :weight

      t.timestamps null: false
    end
  end
end
