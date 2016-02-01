class AddUniqueIndexToExerciseMuscleGroups < ActiveRecord::Migration
  def change
    add_index :exercise_muscle_groups, :muscle_group_id, unique: true
    add_index :exercise_muscle_groups, :exercise_id, unique: true
    add_index :exercise_muscle_groups, [:exercise_id, :muscle_group_id], unique: true, name: "index_exercise_muscle_groups_on_ex_id_and_mg_id"
  end
end
