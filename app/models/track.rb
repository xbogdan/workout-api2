class Track < ActiveRecord::Base
  belongs_to :user
  has_many :track_days
  accepts_nested_attributes_for :track_days, allow_destroy: true
end
