class GroupMemberInfo < ApplicationRecord
	validates :group_member_id, presence: true
	validates :name, presence: true


    belongs_to :group_member, optional: true

    #mount_uploader :icon, IconUploader
	#mount_uploader :background, IconUploader
end
