class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :icon
      t.string :title
      t.string :info
      t.string :background

      t.timestamps
    end
  end
end
