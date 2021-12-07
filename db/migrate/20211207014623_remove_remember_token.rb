class RemoveRememberToken < ActiveRecord::Migration[5.2]
  def change
    remove_column :Users, :remember_token
  end
end
