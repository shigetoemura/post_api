class RemoveGroupPostIdFromGroups < ActiveRecord::Migration[5.2]
  def change
    remove_column :groups, :group_post_id, :bigint
  end
end
