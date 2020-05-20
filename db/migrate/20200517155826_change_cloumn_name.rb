class ChangeCloumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :public, :published
  end
end
