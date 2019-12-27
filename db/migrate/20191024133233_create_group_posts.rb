class CreateGroupPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :group_posts do |t|
      t.bigint :group_member_id
      t.bigint :group_id
      t.string :text
      t.string :icon
      t.bigint :reply_to_id

      t.timestamps
    end
  end
end
