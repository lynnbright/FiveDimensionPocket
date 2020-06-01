class RemoveElementIdFromHighlights < ActiveRecord::Migration[6.0]
  def change
    remove_column :highlights, :element_id, :string
  end
end
