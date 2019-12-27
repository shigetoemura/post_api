class Api::V1::GroupSerializer < ActiveModel::Serializer
  attributes :id,
  			:title,
  			:info,
  			:icon,
  			:background,
  			:member_count,
  			:created_at,
  			:updated_at

  	def member_count
  		if object.group_member_count.present?
  			object.group_member_count.count
  		else
  			0
  		end
  	end
end
