class ExploresController < ApplicationController
  before_action :authenticate_user!
  
  def index  
    # 分組之後不能用欄位直接排序，只能找其欄位值特徵做排序(最大或最小等等)
    users = UserLastArticle.group(:user_id).order('MAX(created_at) DESC').having('COUNT(user_id) > 2').limit(5).count.keys
    
    @Users =  User.includes(:user_last_articles, :articles, :follow_lists).where(id: users)
  end
end
