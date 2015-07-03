class RefreshToken < ActiveRecord::Base
  validates :user, presence: true
  has_secure_token

  belongs_to :user
end
