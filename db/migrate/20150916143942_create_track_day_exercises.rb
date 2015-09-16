class CreateTrackDayExercises < ActiveRecord::Migration
  def change
    create_table :track_day_exercises do |t|
      t.integer :track_day_id
      t.integer :exercise_id

      t.timestamps null: false
    end
  end
end
