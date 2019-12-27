class CreateGroupPostReplyCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :group_post_reply_counts do |t|
      t.bigint :group_post_id
      t.integer :count

      t.timestamps
    end
  end
end
