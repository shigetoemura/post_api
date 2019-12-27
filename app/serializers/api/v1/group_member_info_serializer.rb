class Api::V1::GroupMemberInfoSerializer < ActiveModel::Serializer
  attributes :id,
  			:name,
  			:icon,
  			:created_at,
  			:updated_at
end
