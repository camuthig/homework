class Homework < ActiveRecord::Base
  validates :title, presence: true
  validates :question, presence: true
  validates :due_date, presence: true

  has_many :assignments
  has_many :users, :through => :assignments
end
