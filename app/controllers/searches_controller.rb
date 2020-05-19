class SearchesController < ApplicationController
  def search_articles
    @search = Search.new
    @search_results = current_user.articles.where("title ILIKE ?", "%#{params[:search][:search_input]}%").with_attached_article_images
  end

  private
  def search_input_params
    params.require(:search).permit(:search_input) 
  end
end