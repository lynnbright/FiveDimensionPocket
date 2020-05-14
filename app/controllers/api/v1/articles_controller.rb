require 'json'

class Api::V1::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:favorite, :readed]

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

  def readed
    article = Article.find(params[:id])
    
    if article.changed_by(current_user) && article.readed == false
      article.readed = true
      article.readed_at = Time.now
      article.save
      render json: { status: 'readed'}
    else
      article.readed = false
      article.readed_at = nil
      article.save
      render json: { status: 'unread'}
    end
  end

  def tags
    user_id = current_user.id
    selected_tags = JSON.parse(tags_params[:list_tag])
    article = Article.find(tags_params[:id])     
    article.tag_list= selected_tags
    
    render json: {msg: msg}
  end

  def get_tags
    article = Article.find(tags_params[:id])  
    tags =  article.tag_list

    render json: {tags: tags}
  end

  private
  def tags_params
    params.permit(:id, :list_tag )
  end
  

  def create_speech
    @article = Article.find(params[:id])
    result = HTTParty.post("https://texttospeech.googleapis.com/v1/text:synthesize",
        :headers => {
          "x-goog-api-key" => "AIzaSyBZhcuNoTSKq2Pmp8G-Mt50f92ga1nPuXo",
          "content-type" => "application/json; charset=utf-8",
        },
        :body => {
          "input" => {
            "text" => "#{@article.content}"
          },
          "voice" => {
            "languageCode" => "cmn-TW",
            "name" => "cmn-TW-Wavenet-A-Alpha",
            "ssmlGender" => "FEMALE"
          },
          "audioConfig" => {
            "audioEncoding" => "MP3"
          }
        }.to_json
    )
    render json: {status: "#{result.body}"}

  end

end