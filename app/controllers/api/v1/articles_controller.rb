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
    selected_tag = JSON.parse(tags_params[:list_tag])
    @article = Article.find(tags_params[:id])  


    # 用文章角度來存tag
    selected_tag.each do |selected_tag|
      # 判斷標籤是否已存在，不存在就新增
      # 已存在就累積使用次數

      selected_tag = Tag.new(user_id: user_id,name: selected_tag)
      @article.tags << selected_tag
    end  
    
    render json: {tag: @article.tags}
  end

  def gettags
    @article = Article.find(tags_params[:id])  


    render json: {tag: @article.tags}
  end

  private
  def tags_params
    params.permit(:id, :list_tag )
  end
  
end