class Api::V1::NotificationSerializer < ActiveModel::Serializer
  attributes :id,
  			:from_member,
  			:notificacle_type,
  			:notificable,
  			:created_at,
  			:updated_at

  	def from_member
  		from_member = GroupMember.where(id: object.from_member_id).first
  		if from_member.present?
  			current_group_member = instance.options[:current_group_member]
  			if current_group_member.present?
  				Api::V1::GroupMemberSerializer.new(from_member, current_group_member: current_group_member)
  			else
  				Api::V1::GroupMemberSerializer.new(from_member)
  			end
  		end
  	end

  	def notificable
  		current_group_member = instance.options[:current_group_member]
  		if notificacle_type == "GroupPost"
  			notificable = GroupPost.where(id: notificable_id)
  			Api::V1::GroupPostSerializer.new(notificable, current_group_member: current_group_member)
  		elsif notificacle_type == "GorupAnswer"
  			notificable = GroupAnswer.where(id: notificable_id)
  			Api::V1::GroupAnswerSerializer.new(notificable, current_group_member: current_group_member)
  		end
  	end
end
