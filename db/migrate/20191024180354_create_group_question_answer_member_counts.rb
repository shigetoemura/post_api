class CreateGroupQuestionAnswerMemberCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :group_question_answer_member_counts do |t|
      t.bigint :group_quesiton_id
      t.integer :count

      t.timestamps
    end
  end
end
