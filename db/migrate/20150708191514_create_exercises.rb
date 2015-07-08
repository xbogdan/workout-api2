class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :muscle_group_id

      t.timestamps null: false
    end
  end
end
