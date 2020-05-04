class ApplicationController < ActionController::Base
  before_action :article_new
  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'new'
      "for_user"
    end
  end
  

  private
  def article_new
    @article = current_user ? current_user.articles.new : Article.new
  end

  #補登入 check 
end
