class GroupQuestionAnswerMemberCount < ApplicationRecord
	validates :group_question_id, presence: true
	validates :count, presence: true

	belongs_to :group_question, optional: true
end
