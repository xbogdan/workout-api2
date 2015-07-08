class ProgramDayExercise < ActiveRecord::Base
  belongs_to :program_day
  belongs_to :exercise
end
