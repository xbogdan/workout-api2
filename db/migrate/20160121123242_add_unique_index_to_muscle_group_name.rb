class AddUniqueIndexToMuscleGroupName < ActiveRecord::Migration
  def change
    add_index :muscle_groups, :name, unique: true
  end
end
