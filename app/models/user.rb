class User < ActiveRecord::Base
  enum role: [:teacher, :student]

  validates :username, presence: true, uniqueness: true
  validates :role, presence: true

  has_and_belongs_to_many :homeworks
end
