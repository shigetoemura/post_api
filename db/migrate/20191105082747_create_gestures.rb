class CreateGestures < ActiveRecord::Migration[5.2]
  def change
    create_table :gestures do |t|
      t.string :token
      t.string :device_id

      t.timestamps
    end
  end
end
