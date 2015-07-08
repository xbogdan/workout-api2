class CreateProgramDays < ActiveRecord::Migration
  def change
    create_table :program_days do |t|
      t.string :name
      t.integer :program_id

      t.timestamps null: false
    end
  end
end
