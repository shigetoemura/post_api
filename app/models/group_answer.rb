class GroupAnswer < ApplicationRecord
	validates :group_question_id, presence: true
	validates :group_member_id, presence: true
	validates :text, presence: true

	belongs_to :group_question, optional: true
	has_many :favorites, as: :favorable, dependent: :destroy
	has_one :group_answer_favirites_count, dependent: :destroy
	has_many :group_answer_reports, dependent: :destroy

	#mount_uploader :icon, IconUploader

	def build_favirites_count
		GroupAnswerFaviritesCount.create!(group_answer_id: self.id, count: 0)
    end
end
