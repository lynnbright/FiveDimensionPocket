class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :article_new, :article_all

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'new'
      "for_user"
    end
  end
  

  private
  def article_new
    @article = current_user ? current_user.articles.new : Article.new
  end

  def article_all
    @articles = Article.all
  end

  #補登入 check 
end
