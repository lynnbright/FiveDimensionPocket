class ExploresController < ApplicationController
  before_action :authenticate_user! 
  
  def index  
    @explore_user_id = UserLastArticle.explore_users
    @users = User.includes(:user_last_articles, :articles, :follow_lists).where(id: @explore_user_id)
  end
end
