class AddDetailsToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :introduction, :text
    add_column :groups, :image_id, :string
    add_column :groups, :leader_id, :integer
  end
end
