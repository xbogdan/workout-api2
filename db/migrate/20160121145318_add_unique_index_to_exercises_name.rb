class AddUniqueIndexToExercisesName < ActiveRecord::Migration
  def change
    add_index :exercises, :name, unique: true
  end
end
