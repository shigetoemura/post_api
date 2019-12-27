class ChatRoom < ApplicationRecord
	validates :group_member_id, presence: true
	validates :opponent_user_id, presence: true

	belongs_to :group_member

	has_many :messages, dependent: :destroy
end
