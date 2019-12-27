class AddDeviceUuidToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :device_uuid, :string
  end
end
