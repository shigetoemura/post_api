class Guestuser < ActiveRecord::Migration[5.2]
  def change
  	drop_table :gestures
  end
end
