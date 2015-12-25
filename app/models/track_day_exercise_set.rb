class TrackDayExerciseSet < ActiveRecord::Base
  belongs_to :track_day_exercise
  
  has_one :track_day, through: :track_day_exercise
  has_one :track, through: :track_day
  has_one :user, through: :track
end
