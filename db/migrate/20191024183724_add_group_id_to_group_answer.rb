class AddGroupIdToGroupAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :group_answers, :group_id, :bigint
  end
end
