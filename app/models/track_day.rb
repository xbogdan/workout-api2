class TrackDay < ActiveRecord::Base
  belongs_to :track
  has_many :track_day_exercises
  has_many :exercises, through: :track_day_exercises

  accepts_nested_attributes_for :track_day_exercises, allow_destroy: true
end
