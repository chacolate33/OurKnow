class AddColumnToApplies < ActiveRecord::Migration[5.2]
  def change
    add_column :Applies, :user_id, :integer
    add_column :Applies, :group_id, :integer
  end
end
