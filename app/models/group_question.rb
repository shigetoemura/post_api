class GroupQuestion < ApplicationRecord
	validates :title, presence: true
	validates :group_member_id, presence: true
	validates :group_id, presence: true

	belongs_to :groups, optional: true
	has_one :group_question_answer_member_count
	has_many :group_answers, dependent: :destroy

	def build_answer_member_count
		GroupQuestionAnswerMemberCount.create!(group_question_id: self.id, count: 0)
    end
end
