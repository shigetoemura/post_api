class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.bigint :group_member_id
      t.bigint :opponent_user_id
      t.bigint :notificable_type
      t.bigint :notificable_id

      t.timestamps
    end
  end
end
