class AddOrdToProgramDayExerciseSets < ActiveRecord::Migration
  def change
    add_column :program_day_exercise_sets, :ord, :integer
  end
end
