FactoryGirl.define do
  factory :user do
    factory :teacher do
      sequence(:username){|n| "teacher#{n}"}
      role 'teacher'
    end
    factory :student do
      role 'student'
      sequence(:username){|n| "student#{n}"}

      factory :student_with_homework do
        homeworks {[FactoryGirl.create(:homework, title: 'Your Worst Homework', question: 'Who is the best teacher in all the land?')]}
      end
    end
  end
end
