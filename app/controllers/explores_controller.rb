class ExploresController < ApplicationController
  before_action :authenticate_user!
  
  def index  
    # 分組之後不能用欄位直接排序，只能找其欄位值特徵做排序(最大或最小等等)
    users = UserLastArticle.group(:user_id).order('MAX(created_at) DESC').having('COUNT(user_id) > 2').limit(5).count.keys
    # @Users = User.includes(:articles).where(id: users)
    # 篩出這個使用者在最新文章表ㄉ三篇,把最新三天的文章id去關聯文章

    UserLastArticle.joins(:article).where(user_id: users)

    @Userlast = UserLastArticle.joins(:article).where(user_id: users)
  end
end