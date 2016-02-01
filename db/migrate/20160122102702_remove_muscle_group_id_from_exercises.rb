class RemoveMuscleGroupIdFromExercises < ActiveRecord::Migration
  def change
    remove_column :exercises, :muscle_group_id, :integer
  end
end
