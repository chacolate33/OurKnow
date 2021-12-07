class AddDetailsToKnowledges < ActiveRecord::Migration[5.2]
  def change
    add_column :knowledges, :group_id, :integer
  end
end
