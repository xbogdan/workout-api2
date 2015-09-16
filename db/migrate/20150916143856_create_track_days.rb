class CreateTrackDays < ActiveRecord::Migration
  def change
    create_table :track_days do |t|
      t.integer :track_id
      t.string :name

      t.timestamps null: false
    end
  end
end
