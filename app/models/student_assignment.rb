class StudentAssignment < ActiveRecord::Base
  validates :user, :homework, presence: true
end
