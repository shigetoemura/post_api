class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :icon
      t.string :text
      t.bigint :group_member_id
      t.bigint :chat_room_id

      t.timestamps
    end
  end
end
