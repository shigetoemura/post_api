class User < ApplicationRecord
	before_validation :assign_token

	has_many :user_groups, dependent: :destroy

	def assign_token
    	self.token ||= SecureRandom.uuid
	end

	def build_user_group_for_general
		UserGroup.create!(user_id: self.id, group_id: 1)
	end

	def build_group_member_for_general(name)
		group_member = GroupMember.create!(group_id: 1, user_id: self.id)
		group_member.build_group_member_info(name)
	end

	def default_member_info
		latest_group = Group.find(self.user_groups.first.group_id)
		default_member_info = latest_group.group_members.find_by(user_id: self.id).group_member_info
	end
end
