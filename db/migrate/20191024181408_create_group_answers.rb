class CreateGroupAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_answers do |t|
      t.bigint :group_member_id
      t.bigint :group_question_id
      t.bigint :reply_to_id
      t.string :text
      t.string :icon

      t.timestamps
    end
  end
end
