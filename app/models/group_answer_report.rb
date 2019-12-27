class GroupAnswerReport < ApplicationRecord
	validates :group_member_id, presence: true
	validates :reported_member_id, presence: true

	belongs_to :group_answer, optional: true
end
