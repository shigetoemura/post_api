class CreateGroupAnswerReports < ActiveRecord::Migration[5.2]
  def change
    create_table :group_answer_reports do |t|
      t.bigint :group_answer_id
      t.bigint :group_member_id
      t.string :reason

      t.timestamps
    end
  end
end
