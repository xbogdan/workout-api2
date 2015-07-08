class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name, null: false
      t.string :level, default: nil, null: true
      t.string :goal, default: nil, null: true
      t.boolean :private, default: true, null: false
      t.integer :upvotes, default: 0, null: false
      t.integer :downvotes, default: 0, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
