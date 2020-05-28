class AddEncodeStringToArticleTable < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :encode_string, :string
  end
end
