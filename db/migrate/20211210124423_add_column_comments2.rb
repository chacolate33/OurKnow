class AddColumnComments2 < ActiveRecord::Migration[5.2]
  def change
        add_column :Comments, :user_id, :integer
  end
end
