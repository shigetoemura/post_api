class Api::V1::ReplyToPostSerializer < ActiveModel::Serializer
  attributes :id,
  			:group_member,
  			:group_id,
  			:text,
  			:reply_to_id,
  			:icon,
  			:created_at,
  			:updated_at

  	def group_member
  		group_member = GroupMember.where(id: object.group_member_id).first
  		if group_member.present?
  			Api::V1::GroupMemberSerializer.new(group_member)
  		end
  	end
end
