class ExploresController < ApplicationController
  before_action :authenticate_user!, :find_user_has_three_public_articles
  
  def index  
    @Users =  User.includes(:user_last_articles, :articles, :follow_lists).where(id: @Users)
  end

  def following
    # 找出所有公開超過三篇且被追蹤的
    @Users = @Users.select{ |u_id| current_user.follow_lists.find_by(following_id: u_id) }
    @Users =  User.includes(:user_last_articles, :articles, :follow_lists).where(id: @Users)

    render :index 
  end

  private

  def find_user_has_three_public_articles  
    # 分組之後不能用欄位直接排序，只能找其欄位值特徵做排序(最大或最小等等)
    @Users = UserLastArticle.group(:user_id).order('MAX(created_at) DESC').having('COUNT(user_id) > 2').limit(3).count.keys
  end
end
