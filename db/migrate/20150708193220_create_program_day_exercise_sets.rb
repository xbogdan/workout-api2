class CreateProgramDayExerciseSets < ActiveRecord::Migration
  def change
    create_table :program_day_exercise_sets do |t|
      t.integer :reps
      t.integer :program_day_exercise_id

      t.timestamps null: false
    end
  end
end
