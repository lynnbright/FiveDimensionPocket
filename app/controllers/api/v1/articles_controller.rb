class Api::V1::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:favorite]

  def favorite
    article = Article.find(params[:id])
    
    if article.favorited_by(current_user) && article.favorite == false
      article.favorite = true
      article.save
      render json: { status: 'favorited'}
    else
      article.favorite = false
      article.save
      render json: { status: 'removed'}
    end
  end
end