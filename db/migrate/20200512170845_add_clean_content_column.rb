class AddCleanContentColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :clean_content, :string
    add_column :articles, :short_description, :string 
  end
end
