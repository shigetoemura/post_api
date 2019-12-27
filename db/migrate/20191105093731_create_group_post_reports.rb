class CreateGroupPostReports < ActiveRecord::Migration[5.2]
  def change
    create_table :group_post_reports do |t|
      t.bigint :group_post_id
      t.bigint :group_member_id
      t.string :reason

      t.timestamps
    end
  end
end
