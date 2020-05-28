class ExploresController < ApplicationController
  before_action :authenticate_user!, :user_has_three_public_articles
  
  def index  
    @users = User.includes(:user_last_articles, :articles, :follow_lists).where(id: @explore_user_id)
  end

  def following
    # 篩出所有公開超過三篇且被追蹤的id
    @following_user_id = @explore_user_id.select{ |u_id| current_user.follow_lists.find_by(following_id: u_id) }
    @users = User.includes(:user_last_articles, :articles, :follow_lists).where(id: @following_user_id)

    render :index 
  end

  private

  def user_has_three_public_articles  
    # 分組之後不能用欄位直接排序，只能找其欄位值特徵做排序(最大或最小等等)
    @explore_user_id = UserLastArticle.group(:user_id).order('MAX(created_at) DESC').having('COUNT(user_id) > 2').limit(3).count.keys
  end
end
