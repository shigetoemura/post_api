class CreateGroupMemberInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :group_member_infos do |t|
      t.integer :group_member_id
      t.string :name
      t.string :icon
      t.references :group_member, foreign_key: true

      t.timestamps
    end
  end
end
