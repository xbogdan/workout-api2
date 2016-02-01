class RemoveBadIndexesFromExerciseMuscleGroup < ActiveRecord::Migration
  def change
    remove_index :exercise_muscle_groups, name: "index_exercise_muscle_groups_on_exercise_id"
    remove_index :exercise_muscle_groups, name: "index_exercise_muscle_groups_on_muscle_group_id"
  end
end
