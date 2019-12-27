class ChangeColumnToGroupMember < ActiveRecord::Migration[5.2]
  def change
  	remove_foreign_key :group_members, :users
    remove_index :group_members, :user_id
    remove_reference :group_members, :user

    remove_foreign_key :group_members, :groups
    remove_index :group_members, :group_id
    remove_reference :group_members, :group
  end
end
