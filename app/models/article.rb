class Article < ApplicationRecord
  default_scope { where.not(created_at: nil).order(id: :desc)}
  belongs_to :user
end
