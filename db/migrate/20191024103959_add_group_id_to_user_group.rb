class AddGroupIdToUserGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :user_groups, :group_id, :integer
  end
end
