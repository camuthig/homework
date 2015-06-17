require 'time'

FactoryGirl.define do
  factory :homework do
    due_date 1.day.from_now
  end

end
