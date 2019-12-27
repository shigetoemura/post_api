class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.bigint :group_member_id
      t.bigint :opponent_user_id

      t.timestamps
    end
  end
end
