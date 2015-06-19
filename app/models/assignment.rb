class Assignment < ActiveRecord::Base
  validates :homework, :user, presence: true

  belongs_to :user
  belongs_to :homework
  has_many :answers
end
