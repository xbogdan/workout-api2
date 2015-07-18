class AddOrdToProgramDayExercises < ActiveRecord::Migration
  def change
    add_column :program_day_exercises, :ord, :integer
  end
end
