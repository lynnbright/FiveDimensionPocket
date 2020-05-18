class AddSearchColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :search, :string
  end
end
