class CreateKnowledges < ActiveRecord::Migration[5.2]
  def change
    create_table :knowledges do |t|
      t.integer :user_id, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
