class RemoveGroupIdFromGroupAnswer < ActiveRecord::Migration[5.2]
  def change
    remove_column :group_answers, :group_id, :bigint
  end
end
