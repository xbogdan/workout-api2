class TrackDayExercise < ActiveRecord::Base
  belongs_to :track_day
  belongs_to :exercise

  has_one :track, through: :track_day
  has_one :user, through: :track

  has_many :track_day_exercise_sets
  accepts_nested_attributes_for :track_day_exercise_sets, allow_destroy: true
end
