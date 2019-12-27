class CreateGroupQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :group_questions do |t|
      t.bigint :group_member_id
      t.bigint :group_id
      t.string :title

      t.timestamps
    end
  end
end
