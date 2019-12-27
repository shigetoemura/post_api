class RenameOpponentUserIdColumnToNotifications < ActiveRecord::Migration[5.2]
  def change
  	rename_column :notifications, :opponent_user_id, :from_member_id
  end
end
