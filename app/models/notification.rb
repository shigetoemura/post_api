class Notification < ApplicationRecord
	validates :group_member_id, presence: true
	validates :from_member_id, presence: true
	validates :notificable_type, presence: true
	validates :notificable_id, presence: true

	belongs_to :group_member
	belongs_to :notificable, polymorphic: true
end
