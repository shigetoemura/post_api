class GroupPost < ApplicationRecord
	validates :text, presence: true
	validates :group_id, presence: true
	validates :group_member_id, presence: true

	belongs_to :group, optional: true
	has_one :group_post_reply_count, dependent: :destroy
	has_one :group_post_favirites_count, dependent: :destroy
	has_many :favorites, as: :favorable, dependent: :destroy
	has_many :group_post_reports, dependent: :destroy

	#mount_uploader :icon, IconUploader

	def build_favirites_count
		GroupPostFaviritesCount.create!(group_post_id: self.id, count: 0)
	end


	def build_replies_count
		GroupPostReplyCount.create!(group_post_id: self.id, count: 0)
	end

	def build_post_reply_notification
		reply_post = GroupPost.where(id: self.rely_to_id).first
		Notification.create!(notificable: reply_post, group_member_id: reply_post.group_member_id, opponent_user: self.group_member_id)
	end

	def build_post_favorite_notification(from_member_id)
		Notification.create!(notificable: self, group_member_id: self.group_member_id, opponent_user: opponent_user_id)
	end
end
