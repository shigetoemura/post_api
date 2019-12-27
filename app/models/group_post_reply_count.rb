class GroupPostReplyCount < ApplicationRecord
	validates :count, presence: true
	validates :group_post_id, presence: true

	belongs_to :group_post
end
