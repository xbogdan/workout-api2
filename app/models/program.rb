class Program < ActiveRecord::Base
  belongs_to :user
  has_many :program_days
  accepts_nested_attributes_for :program_days, allow_destroy: true
end
