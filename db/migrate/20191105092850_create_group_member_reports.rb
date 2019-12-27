class CreateGroupMemberReports < ActiveRecord::Migration[5.2]
  def change
    create_table :group_member_reports do |t|
      t.bigint :group_member_id
      t.string :reason
      t.bigint :reported_member_id

      t.timestamps
    end
  end
end
