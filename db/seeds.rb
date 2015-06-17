# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
FactoryGirl.create(:teacher, username: 'teacher')
FactoryGirl.create(:student_with_homework, username: 'student')
FactoryGirl.create(:homework, title: 'Your First Homework', question: 'Who is the best teacher in all the land?')
FactoryGirl.create(:homework, title: 'Much Harder Homework', question: 'What is your favorite color?')
