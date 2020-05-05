class Article < ApplicationRecord
  has_many :article_tags
  has_many :tags, through :article_tags
  default_scope { where.not(created_at: nil).order(id: :desc)}
end
