class Homework < ActiveRecord::Base
  validates :title, presence: true
  validates :question, presence: true
  validates :due_date, presence: true

  has_and_belongs_to_many :users
end
