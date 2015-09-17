class TrackDay < ActiveRecord::Base
  belongs_to :track
  has_many :track_day_exercises
  has_many :exercises, through: :track_day_exercises
  
  belongs_to :program_day

  accepts_nested_attributes_for :track_day_exercises, allow_destroy: true
end
