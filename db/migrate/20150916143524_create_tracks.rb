class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :user_id
      t.integer :program_id, default: nil, null: true

      t.timestamps null: false
    end
  end
end
