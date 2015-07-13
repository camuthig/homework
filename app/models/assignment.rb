class Assignment < ActiveRecord::Base
  validates :homework, :user, presence: true
  validates :user, uniqueness: { scope: :homework, message: " is already assigned to the homework" }

  belongs_to :user
  belongs_to :homework
  has_many :answers
end
