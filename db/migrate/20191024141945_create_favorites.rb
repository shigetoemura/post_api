class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string :favorable_type
      t.bigint :favorable_id
      t.bigint :group_member_id

      t.timestamps
    end
  end
end
