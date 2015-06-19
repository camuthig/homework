# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create some basic needs
FactoryGirl.create(:teacher, username: 'teacher')
student = FactoryGirl.create(:student, username: 'student')
lazy_student = FactoryGirl.create(:student, username: 'lazy_student')
homework = FactoryGirl.create(:homework, title: 'Your First Homework', question: 'Who is the best teacher in all the land?')
FactoryGirl.create(:homework, title: 'Much Harder Homework', question: 'What is your favorite color?')

# Add the assignment to our users
assignment = FactoryGirl.create(:assignment, user: student, homework: homework)
FactoryGirl.create(:assignment, user: lazy_student, homework: homework)

# Give our good student a couple of answers, with time separation.
FactoryGirl.create(:answer, answer: "Yar!", assignment: assignment)
sleep(1)
FactoryGirl.create(:answer, answer: "You are!", assignment: assignment)