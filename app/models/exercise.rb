class Exercise < ActiveRecord::Base
  has_one :muscle_group
  
  has_many :program_day_exercises
  has_many :programs, through: :program_day_exercises
end
