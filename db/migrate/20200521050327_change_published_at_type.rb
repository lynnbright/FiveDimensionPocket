class ChangePublishedAtType < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :published_at
    add_column :articles, :published_at, :datetime
  end
end
