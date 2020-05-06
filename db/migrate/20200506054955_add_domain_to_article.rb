class AddDomainToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :domain, :string
  end
end
