class Api::V1::SignUpSerializer < ActiveModel::Serializer
  attributes :id,
  			:assigned_group_members,
  			:assigned_groups,
  			:token,
  			:created_at,
  			:updated_at

  	def assigned_groups
        assigned_group_ids = object.user_groups.pluck(:group_id)
        assigned_groups = Group.where("id IN (?)", assigned_group_ids)
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
            assigned_groups,
            serializer: Api::V1::GroupSerializer
        )
    	serializer.as_json
    end

    def assigned_group_members
        assigned_group_ids = object.user_groups.pluck(:group_id)
        assigned_group_members = GroupMember.where("group_id IN (?)", assigned_group_ids).where(user_id: object.id)
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
            assigned_group_members,
            serializer: Api::V1::GroupMemberMeSerializer
        )
    	  serializer.as_json
    end
end
