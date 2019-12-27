class Api::V1::GroupMemberMeSerializer < ActiveModel::Serializer
  attributes :id,
  			:group_id,
  			:group_member_info,
  			:token,
  			:created_at,
  			:updated_at

  	def group_member_info
  		Api::V1::GroupMemberInfoSerializer.new(object.group_member_info)
  	end
end
