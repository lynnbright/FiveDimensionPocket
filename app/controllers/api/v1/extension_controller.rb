class Api::V1::ExtensionController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :save
  def save
    if valid_user?
      create_article()
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
      else
        render json: {message: '重新試一次'}, status: 401
      end
    else
      check_article_exist.update(created_at: Time.now)
    end
  end
end
