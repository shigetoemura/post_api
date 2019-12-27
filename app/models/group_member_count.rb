class GroupMemberCount < ApplicationRecord
	validates :group_id, presence: true
	validates :count, presence: true

	belongs_to :group,  optional: true
end
