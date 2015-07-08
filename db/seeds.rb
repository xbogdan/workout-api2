# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(email: 'bogdan.boamfa@gmail.com', password: 'bogdan5393')

program = user.programs.create(
  name: 'Program 1',
  goal: 'Strength',
  level: 'Intermmediate',
  private: false
)

4.times do |i|
  day = program.program_days.create(
    name: "Day "+i.to_s
  )
end

user.programs.create(
  name: 'Program 2',
  goal: 'Muscle',
  level: 'Advanced',
  private: true
)
