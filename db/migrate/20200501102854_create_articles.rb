class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.text :content
      t.string :title
      t.string :link
      t.boolean :favorite
      t.boolean :readed
      t.datetime :readed_at
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :articles, :deleted_at
  end
end
