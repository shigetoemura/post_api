class ChangeColumnToUserGroup < ActiveRecord::Migration[5.2]
  def change
  	remove_foreign_key :user_groups, :users
    remove_index :user_groups, :user_id
    remove_reference :user_groups, :user

    remove_foreign_key :user_groups, :groups
    remove_index :user_groups, :group_id
    remove_reference :user_groups, :group
  end
end
