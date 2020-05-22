class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.articles.order(id: :desc).with_attached_article_images.limit(5)
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    service = ArticleSendApiService.new(url_params[:link])
    result = service.perform

    if result[:success]
      response_hash = result[:data]

      @article.assign_attributes({
        user_id: current_user.id,
        link: url_params[:link],
        title: response_hash['title'],
        content: response_hash['text'],
        domain: response_hash['domain'],
        images: response_hash['images'] << result[:extract_data][:ogimage_address],
        clean_html: result[:extract_data][:clean_html],
        clean_content: result[:extract_data][:clean_content],
        short_description: result[:extract_data][:short_description],
      })
      # @article.images = response_hash['images']
      @article.save
      redirect_to articles_path
    else
      redirect_to articles_path, alert: '請重新再試一次'
    end
  end

  def favorites
    @favorite_articles = current_user.articles.where(favorite: true)
  end


  private
  def url_params
    params.require(:article).permit(:link, article_images: []) 
  end

end