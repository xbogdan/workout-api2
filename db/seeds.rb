# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# MuscleGroup.create(id: 1, name: 'Triceps')
# MuscleGroup.create(id: 2, name: 'Biceps')
# MuscleGroup.create(id: 3, name: 'Chest')
# MuscleGroup.create(id: 4, name: 'Shoulders')
# MuscleGroup.create(id: 5, name: 'Lats')
# MuscleGroup.create(id: 6, name: 'Traps')
# MuscleGroup.create(id: 7, name: 'Hamstrings')
# MuscleGroup.create(id: 8, name: 'Quadriceps')
# MuscleGroup.create(id: 9, name: 'Forearm')
# MuscleGroup.create(id: 10, name: 'Lower back')
# MuscleGroup.create(id: 11, name: 'Middle back')
# MuscleGroup.create(id: 12, name: 'Calves')
# MuscleGroup.create(id: 13, name: 'Glutes')
# MuscleGroup.create(id: 14, name: 'Abs')
# MuscleGroup.create(id: 15, name: 'Neck')

# Exercise.create(id: 1, name: 'Skullcrasher', muscle_group_id: 1)
# Exercise.create(id: 2, name: 'Close grip barbell bench press', muscle_group_id: 1)
# Exercise.create(id: 3, name: 'Barbell curl', muscle_group_id: 2)
# Exercise.create(id: 4, name: 'Dumbell alternate biceps curl', muscle_group_id: 2)
# Exercise.create(id: 5, name: 'Barbell bench press', muscle_group_id: 3)
# Exercise.create(id: 6, name: 'Dumbell bench press', muscle_group_id: 3)
# Exercise.create(id: 7, name: 'Include dumbell bench press', muscle_group_id: 3)


user = User.create(email: 'bogdan.boamfa@gmail.com', password: 'bogdan')

# program = user.programs.create(
#   name: 'Program 1',
#   goal: 'Strength',
#   level: 'Intermmediate',
#   private: false
# )
#
# 4.times do |i|
#   day = program.program_days.create(
#     name: "Day "+i.to_s
#   )
#   4.times do |j|
#     pde = day.program_day_exercises.create(exercise_id: rand(1..7))
#     3.times do |j|
#       pde.program_day_exercise_sets.create(reps: rand(4..8))
#     end
#   end
# end
