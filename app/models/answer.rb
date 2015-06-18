class Answer < ActiveRecord::Base
    validates :answer, presence: true

    belongs_to :assignment
end
