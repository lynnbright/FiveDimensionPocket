class AddCleanHtmlColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :clean_html, :string 
  end
end
