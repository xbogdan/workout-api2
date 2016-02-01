class Exercise < ActiveRecord::Base
  belongs_to :user

  has_many :program_day_exercises
  has_many :programs, through: :program_day_exercises

  has_many :exercise_muscle_groups
  has_many :muscle_groups, through: :exercise_muscle_groups
end
