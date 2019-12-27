class RemoveGroupAnswerIdFromGroupQuestion < ActiveRecord::Migration[5.2]
  def change
    remove_column :group_questions, :group_answer_id, :bigint
  end
end
