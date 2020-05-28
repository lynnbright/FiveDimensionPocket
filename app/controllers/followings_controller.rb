class FollowingsController < ApplicationController
  def index
    @explore_user_id = UserLastArticle.explore_users
    # 篩出所有公開超過三篇且被追蹤的id
    @following_user_id = @explore_user_id.select{ |u_id| current_user.follow_lists.find_by(following_id: u_id) }
    @users = User.includes(:user_last_articles, :articles, :follow_lists).where(id: @following_user_id)
  end
end
