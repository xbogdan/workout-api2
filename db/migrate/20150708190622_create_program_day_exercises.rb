class CreateProgramDayExercises < ActiveRecord::Migration
  def change
    create_table :program_day_exercises do |t|
      t.integer :program_day_id
      t.integer :exercise_id

      t.timestamps null: false
    end
  end
end
