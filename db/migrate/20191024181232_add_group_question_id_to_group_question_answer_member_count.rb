class AddGroupQuestionIdToGroupQuestionAnswerMemberCount < ActiveRecord::Migration[5.2]
  def change
    add_column :group_question_answer_member_counts, :group_question_id, :bigint
  end
end
