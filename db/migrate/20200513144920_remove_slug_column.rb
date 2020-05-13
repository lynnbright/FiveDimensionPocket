class RemoveSlugColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :slug
  end
end
