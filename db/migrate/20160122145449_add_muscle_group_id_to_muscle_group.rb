class AddMuscleGroupIdToMuscleGroup < ActiveRecord::Migration
  def change
    add_column :muscle_groups, :muscle_group_id, :integer, null: true, default: nil
  end
end
