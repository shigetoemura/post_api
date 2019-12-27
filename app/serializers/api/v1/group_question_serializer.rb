class Api::V1::GroupQuestionSerializer < ActiveModel::Serializer
  attributes :id,
  			 :group_member,
  			 :title,
             :latest_answer,
             :latest_answered_group_members,
             :answered_group_members_count,
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

    def latest_answer
      latest_answer = object.group_answers.first
      if latest_answer.present?
        current_group_member = instance_options[:current_group_member]
        if current_group_member.present?
          Api::V1::GroupAnswerSerializer.new(latest_answer, current_group_member: current_group_member) 
        else
          Api::V1::GroupAnswerSerializer.new(latest_answer)
        end
      end
    end

    def latest_answered_group_members
        latest_5_answers = object.group_answers.slice(0..5)
        if latest_5_answers.present?
          current_group_member = instance_options[:current_group_member]
          if current_group_member.present?
            serializer = ActiveModel::Serializer::CollectionSerializer.new(
              latest_5_answers,
              serializer: Api::V1::GroupAnswerSerializer,
              current_group_member: current_group_member
              )
            serializer
          else
            serializer = ActiveModel::Serializer::CollectionSerializer.new(
              latest_5_answers,
              serializer: Api::V1::GroupAnswerSerializer
              )
            serializer
          end
        end
    end

    def answered_group_members_count
      object.group_question_answer_member_count.count
    end
end
