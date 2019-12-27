class GroupMember < ApplicationRecord
	validates :user_id, presence: true
	validates :group_id, presence: true

	belongs_to :user
    belongs_to :group, optional: true

    has_one :group_member_info, dependent: :destroy

    has_many :favorites, dependent: :destroy
    has_many :notifications, dependent: :destroy
    has_many :chat_rooms, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
	has_many :followings, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower
	has_many :group_member_reports, dependent: :destroy

    before_validation :assign_token

    def assign_token
    	self.token ||= SecureRandom.uuid
	end

	def build_group_member_info(name)
		GroupMemberInfo.create!(group_member_id: self.id, name: name)
	end

	def build_group_member_info_with_default_info(user_id, group_id)
		user = User.find(user_id)
		default_member_info = user.default_member_info
		self.build_group_member_info(default_member_info.name)
	end

	def follow(other_member)
		followings << other_member
	end

	def unfollow(other_member)
		active_relationships.find_by(followed_id: other_member.id).destroy
	end

	def following?(other_member)
		followings.include?(other_member)
	end

end
