class AddUserIdToGroupMember < ActiveRecord::Migration[5.2]
  def change
    add_column :group_members, :user_id, :integer
  end
end
