class Api::V1::ExtensionController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :save
  skip_before_action :create_tags_menu
  def save
    if valid_user?
      create_article()
      save_tags()
    end
  end

  private
  
  def valid_user?
    @user = User.find_by(auth_token: params[:key])
  end

  def create_article
    #成功抓到url並且打出API
    check_article_exist = @user.articles.where("link LIKE '#{params[:url]}'")

    if check_article_exist.blank?
      service = ArticleSendApiService.new(params[:url])
      result = service.perform

      if result[:success]
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
      else
        render json: {message: '此網站無法存取'}, status: 401
      end
    else
      check_article_exist.update(created_at: Time.now)
      render json: {message: '此網站儲存過'}, status: 200
    end
  end

  def save_tags
    byebug
  end
end
