class RemoveDeviceIdFromGestuser < ActiveRecord::Migration[5.2]
  def change
    remove_column :gestusers, :device_id, :string
  end
end
