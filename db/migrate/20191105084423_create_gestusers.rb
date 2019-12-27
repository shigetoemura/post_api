class CreateGestusers < ActiveRecord::Migration[5.2]
  def change
    create_table :gestusers do |t|
      t.string :token
      t.string :device_id

      t.timestamps
    end
  end
end
