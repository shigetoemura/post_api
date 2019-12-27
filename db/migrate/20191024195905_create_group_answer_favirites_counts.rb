class CreateGroupAnswerFaviritesCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :group_answer_favirites_counts do |t|
      t.bigint :group_answer_id
      t.integer :count

      t.timestamps
    end
  end
end
