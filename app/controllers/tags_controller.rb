class TagsController < ApplicationController
  def show
    # 確認tag是current_user的
    @tag_articles = current_user.tags.includes(:articles).where(id: params[:id]).first.articles
    # u1.tags.includes(:articles).find_by(id: 1).articles
    # u2.tags.includes(:articles).where(id: 4).first.articles
  end
end
