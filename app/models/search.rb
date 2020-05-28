class Search < ApplicationRecord
  extend ActiveModel::Naming
  belongs_to :user
  has_many :articles
end
