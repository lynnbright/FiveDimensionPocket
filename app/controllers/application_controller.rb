class ApplicationController < ActionController::Base
  before_action :article_new, :article_all
  private

  def article_new
    @article = current_user ? current_user.articles.new : Article.new
  end

  def article_all
    @articles = Article.all
  end

  #補登入 check 
end
