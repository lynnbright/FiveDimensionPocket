class ChangeReadedAtName < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :readed_at, :read_at
  end
end
