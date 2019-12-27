class RemoveGroupQuesitonIdFromGroupQuestionAnswerMemberCount < ActiveRecord::Migration[5.2]
  def change
    remove_column :group_question_answer_member_counts, :group_quesiton_id, :bigint
  end
end
