class Api::V1::GroupPostSerializer < ActiveModel::Serializer
  attributes :id,
  			:group_member,
  			:group_id,
  			:text,
  			:reply_to,
  			:icon,
  			:favorites_count,
        :is_favorite,
        :replies_count,
  			:created_at,
  			:updated_at

  	def group_member
  		group_member = GroupMember.where(id: object.group_member_id).first
      if group_member.present?
        current_group_member = instance_options[:current_group_member]
        if current_group_member.present?
          Api::V1::GroupMemberSerializer.new(group_member, current_group_member: current_group_member)
        else
          Api::V1::GroupMemberSerializer.new(group_member)
        end
      end
  	end

  	def reply_to
      reply_post = GroupPost.where(id: object.reply_to_id).first
      if reply_post.present?
        current_group_member = instance_options[:current_group_member]
        if current_group_member.present?
          Api::V1::ReplyToPostSerializer.new(reply_post, current_group_member: current_group_member)
        else
          Api::V1::ReplyToPostSerializer.new(reply_post)
        end
      end
    end

    def favorites_count
      object.group_post_favirites_count.count
    end

    def is_favorite
      if instance_options[:current_group_member].present?
        instance_options[:current_group_member].favorites.where(favorable: object).present?
      else
        false
      end
    end

    def replies_count
      object.group_post_reply_count.count
    end

end
