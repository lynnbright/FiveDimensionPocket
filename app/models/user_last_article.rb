class UserLastArticle < ApplicationRecord
  has_many :users
  belongs_to :article
  # has_many :articles

  def self.explores 
    self.all.order(:user_id)
  end
end
