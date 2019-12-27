class Api::V1::GroupAnswerSerializer < ActiveModel::Serializer
  attributes :id,
  			:group_member,
  			:text,
  			:favorites_count,
        :is_favorite,
  			:reply_to,
  			:icon,
  			:created_at,
  			:updated_at

  	 def group_member
      group_member = GroupMember.where(id: object.group_member_id).first
      if group_member.present?
        Api::V1::GroupMemberSerializer.new(group_member)
      end
    end

    def reply_to
      reply_post = GroupAnswer.where(id: object.reply_to_id).first
      if reply_post.present?
          Api::V1::ReplyToPostSerializer.new(reply_post)
      end
    end

    def favorites_count
      object.group_answer_favirites_count.count
    end

    def is_favorite
      if instance_options[:current_group_member].present?
        instance_options[:current_group_member].favorites.where(favorable: object).present?
      else
        false
      end
    end

end
