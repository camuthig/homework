class Answer < ActiveRecord::Base
    validates :assignment, :answer, presence: true

    belongs_to :assignment
end
