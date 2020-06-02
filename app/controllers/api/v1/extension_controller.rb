class Api::V1::ExtensionController < ApplicationController
  skip_before_action :verify_authenticity_token, :create_tags_menu
  def save_article
    create_article if valid_user? 
  end

  def save_tags
    article_tags if valid_user?
  end

  def create_article
    #成功抓到url並且打出API
    check_article_exist = @user.articles.where("link LIKE '#{params[:url]}'")

    if check_article_exist.blank?
      service = ArticleSendApi.new(params[:url])
      result = service.perform
      
      if result[:api_success]
        response_hash = result[:data]

        @article.assign_attributes({
          user_id: @user.id,
          link: params[:url],
          title: response_hash['title'],
          content: response_hash['text'],
          domain: response_hash['domain'],
          images: response_hash['images'] << result[:extract_data][:ogimage_address],
          clean_html: result[:extract_data][:clean_html],
          clean_content: result[:extract_data][:clean_content],
          short_description: result[:extract_data][:short_description],
        })
        @article.save
        render json: {message: '儲存成功!'}, status: 200

      elsif result[:nokogiri_success] == 'nokogiri_success'
        @article.assign_attributes({
          user_id: @user.id,
          link: params[:url],
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
        render json: {message: '此網站無法存取'}, status: 401
      end
    else
      check_article_exist.update(created_at: Time.now)
      render json: {message: '此網站儲存過'}, status: 200
    end
  end

  #儲存標籤
  def article_tags
    selected_tags = params[:tags]
    article = Article.find_by(link: params[:url])
    article.tag_list = selected_tags
    render json: {message: '儲存成功!'}, status: 200
  end

  private
  
  def valid_user?
    @user = User.find_by(auth_token: params[:key])
  end

end
