class RemoveGroupQuestionIdFromGroupAnswer < ActiveRecord::Migration[5.2]
  def change
    remove_column :group_answers, :group_question_id, :bigint
  end
end
