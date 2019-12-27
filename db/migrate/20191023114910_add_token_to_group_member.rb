class AddTokenToGroupMember < ActiveRecord::Migration[5.2]
  def change
    add_column :group_members, :token, :string
  end
end
