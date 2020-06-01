class CreateHighlights < ActiveRecord::Migration[6.0]
  def change
    create_table :highlights do |t|
      t.string :content
      t.string :element_id
      t.integer :paragraph_index
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
