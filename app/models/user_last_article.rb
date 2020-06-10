class UserLastArticle < ApplicationRecord
  has_many :users
  belongs_to :article

  def self.explore_users 
    # 分組之後不能用欄位直接排序，只能找其欄位值特徵做排序(最大或最小等等)
    self.group(:user_id).order('MAX(created_at) DESC').having('COUNT(user_id) > 2').count.keys
  end
end
