class CreateGroupPostFaviritesCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :group_post_favirites_counts do |t|
      t.integer :count
      t.bigint :group_post_id

      t.timestamps
    end
  end
end
