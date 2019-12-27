class GroupAnswerFaviritesCount < ApplicationRecord
	validates :count, presence: true
    validates :group_answer_id, presence: true

    belongs_to :group_answer
end
