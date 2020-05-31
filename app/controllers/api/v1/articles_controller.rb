require 'json'

class Api::V1::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:favorite, :read]

  def favorite
    article = Article.find(params[:id])
    
    if article.changed_by(current_user) && article.favorite == false
      article.favorite = true
      article.save
      render json: { status: 'favorited'}
    else
      article.favorite = false
      article.save
      render json: { status: 'removed'}
    end
  end

  def read
    article = Article.find(params[:id])
    
    if article.changed_by(current_user) && article.read == false
      article.read = true
      article.read_at = Time.now
      article.save
      render json: { status: 'read'}
    else
      article.read = false
      article.read_at = nil
      article.save
      render json: { status: 'unread'}
    end
  end

  def publish
    article = Article.find(params[:id])
    
    if article.publish == false
      article.publish = true
      article.published_at = Time.now
      article.save
      if current_user.user_last_articles.count >= 3       
        current_user.user_last_articles.order(:created_at).first.destroy      
      end
      UserLastArticle.create(user_id: article.user_id, article_id: article.id)
      render json: { status: 'published'}

    else
      article.publish = false
      article.published_at = nil
      article.save
      in_last_articles = current_user.user_last_articles.find_by(article_id: article.id)
      if in_last_articles 
        current_user.user_last_articles.destroy_all
        last_articles = current_user.articles.where(publish: true).order(published_at: :desc).limit(3)
        last_articles.each do | last_article |
          UserLastArticle.create(user_id: current_user.id, article_id: last_article.id)
        end
      end
      
      render json: { status: 'private'}
    end
  end

  def tags
    user_id = current_user.id
    selected_tags = JSON.parse(tags_params[:list_tag])
    article = Article.find(tags_params[:id])     
    article.tag_list= selected_tags
  end

  def get_tags
    article = Article.find(tags_params[:id])  
    tags =  article.tag_list

    render json: {tags: tags}
  end 

  def create_speech
    @article = Article.find(params[:id])
    response = HTTParty.post("https://texttospeech.googleapis.com/v1/text:synthesize",
        :headers => {
          "x-goog-api-key" => "#{ENV['x-goog-api-key']}",
          "content-type" => "application/json; charset=utf-8",
        },
        :body => {
          "input":{
            "text": "#{@article.content}"
          },
          "voice":{
            "languageCode":"cmn-CN",
            "name":"cmn-CN-Wavenet-A",
            "ssmlGender":"FEMALE"
          },
          "audioConfig":{
            "audioEncoding":"MP3"
          }
        }.to_json
    )
    if response.code == 200
      response_hash = JSON.parse(response.body)   #{ "audioContent": "...."}      
      @response_encode = response_hash["audioContent"]
      @article.encode_string = @response_encode
      @article.save
    end
  end

  def highlight
    highlight = Article.find_by(id: params[:id]).highlights.create(content: highlight_params[:content],
                                                paragraph_index: highlight_params[:paragraph_index])
    render json: { id: highlight.id}  
  end

  def get_highlights
    highlights = Article.find_by(id: params[:id]).highlights
    render json: { highlights: highlights}    
  end

  def delete_highlight
    Article.find(params[:id]).highlights.find(params[:highlight_id]).destroy
  end

  private
  def tags_params
    params.permit(:id, :list_tag )
  end

  def highlight_params
    params.permit(:content, :paragraph_index)
  end
end