class CreateGroupMemberCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :group_member_counts do |t|
      t.integer :group_id
      t.bigint :count

      t.timestamps
    end
  end
end
