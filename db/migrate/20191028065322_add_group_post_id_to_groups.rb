class AddGroupPostIdToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :group_post_id, :bigint
  end
end
