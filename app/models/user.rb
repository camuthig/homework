class User < ActiveRecord::Base
  enum role: [:teacher, :student]

  validates :username, presence: true, uniqueness: true
  validates :role, presence: true

  has_many :assignments
  has_many :homeworks, :through => :assignments
end
