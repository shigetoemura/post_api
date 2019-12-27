class AddGroupPostIdToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :group_post_id, :bigint
  end
end
