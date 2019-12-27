class AddGroupAnswerIdToGroupQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :group_questions, :group_answer_id, :bigint
  end
end
