class ArticlesController < ApplicationController
  before_action :authenticate_user!
  layout "article", only: [:show]

  def index
    @articles = current_user.articles.order(created_at: :desc).with_attached_article_images
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    check_article_exist = current_user.articles.where("link LIKE '#{url_params[:link]}'")

    if check_article_exist.blank?
      service = ArticleSendApi.new(url_params[:link])
      result = service.perform
 
      if result[:api_success]
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
        @article.save

      
      elsif result[:nokogiri_success] == 'nokogiri_success'
        @article.assign_attributes({
          user_id: current_user.id,
          link: url_params[:link],
          title: result[:extract_data][:title],
          content: result[:extract_data][:content],
          domain: result[:extract_data][:domain],
          images: [result[:extract_data][:ogimage_address]],
          clean_html: result[:extract_data][:clean_html],
          clean_content: result[:extract_data][:clean_html],
          short_description: result[:extract_data][:short_description]
        })
        @article.save
      else
        flash[:alert] = '請重新再試一次'
      end
    else
      check_article_exist.update(created_at: Time.now)
    end
    redirect_to articles_path
  end

  def favorites
    @favorite_articles = current_user.articles.where(favorite: true)
  end

  def read_collection 
    @read_collection = current_user.articles.where(read: true).order(created_at: :desc).with_attached_article_images
  end

  def unread_collection 
    @unread_collection = current_user.articles.where(read: false).order(created_at: :desc).with_attached_article_images
  end

  private
  def url_params
    params.require(:article).permit(:link, article_images: []) 
  end
end