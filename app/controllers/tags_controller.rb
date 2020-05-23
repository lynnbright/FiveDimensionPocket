class TagsController < ApplicationController
  def show
    @tag_articles = current_user.tags.includes(:articles).where(id: params[:id]).first.articles
  end
end
