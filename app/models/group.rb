class Group < ApplicationRecord
	validates :title, presence: true

    has_many :user_groups, dependent: :destroy
    has_one :group_member_count, dependent: :destroy
	has_many :group_members, dependent: :destroy
	has_many :group_posts, dependent: :destroy
	has_many :group_questions, dependent: :destroy


	#mount_uploader :icon, IconUploader
	#mount_uploader :background, IconUploader

	def build_other_tables_sametimes(user_id)
		user = User.find(user_id)
		default_member_info = user.default_member_info
		member = GroupMember.create!(group_id: self.id, user_id: user_id)
		member.build_group_member_info(default_member_info.name)
		GroupMemberCount.create!(group_id: self.id, count: 1)
	end
end
