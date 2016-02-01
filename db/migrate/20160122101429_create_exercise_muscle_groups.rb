class CreateExerciseMuscleGroups < ActiveRecord::Migration
  def change
    create_table :exercise_muscle_groups do |t|
      t.integer :exercise_id
      t.integer :muscle_group_id
      t.boolean :primary

      t.timestamps null: false
    end
  end
end
