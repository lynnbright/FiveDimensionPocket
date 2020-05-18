class AddSearchInputColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :searches, :search_input, :string
  end
end
