class RemoveSearchFromArticlesTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :search
  end
end
