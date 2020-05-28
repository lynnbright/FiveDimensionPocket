class ChangeReadedPublishedFavoriteDefaultAndName < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :readed, :read
    rename_column :articles, :published, :publish
    change_column_default :articles, :read, false
    change_column_default :articles, :publish, false
    change_column_default :articles, :favorite, false
  end
end
