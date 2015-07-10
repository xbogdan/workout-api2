class ProgramDay < ActiveRecord::Base
  belongs_to :program
  has_many :program_day_exercises
  has_many :exercises, through: :program_day_exercises

  accepts_nested_attributes_for :program_day_exercises, allow_destroy: true
end
