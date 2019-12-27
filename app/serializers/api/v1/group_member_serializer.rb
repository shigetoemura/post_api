class Api::V1::GroupMemberSerializer < ActiveModel::Serializer
  attributes :id,
  			:group_id,
  			:group_member_info,
  			:followings,
  			:created_at,
  			:updated_at

  	def group_member_info
  		Api::V1::GroupMemberInfoSerializer.new(object.group_member_info)
  	end

  	def folowings
  		current_group_member = instance_options[:current_group_member]
  		if current_group_member.present?
  			current_group_member.following?(object)
  		else
  			false
  		end
  	end
end
