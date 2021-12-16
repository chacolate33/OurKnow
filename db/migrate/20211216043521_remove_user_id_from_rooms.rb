class RemoveUserIdFromRooms < ActiveRecord::Migration[5.2]
  def up
    remove_column :rooms, :users_id
  end
end
