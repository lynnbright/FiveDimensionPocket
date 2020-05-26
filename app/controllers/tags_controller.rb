class TagsController < ApplicationController
  def show
    @tag_articles = current_user.tags.includes(:articles).find(params[:id]).articles
  end
end
