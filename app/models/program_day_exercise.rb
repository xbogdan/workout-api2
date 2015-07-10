class ProgramDayExercise < ActiveRecord::Base
  belongs_to :program_day
  belongs_to :exercise

  has_many :program_day_exercise_sets
  accepts_nested_attributes_for :program_day_exercise_sets, allow_destroy: true
end
