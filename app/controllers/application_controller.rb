class ApplicationController < ActionController::Base
  before_action :article_new

  private

  def article_new
    @article = current_user ? current_user.articles.new : Article.new
  end

  #補登入 check 
end
