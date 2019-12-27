class GroupPostReport < ApplicationRecord
	validates :group_member_id, presence: true
	validates :group_post_id, presence: true

	belongs_to :group_post
end
