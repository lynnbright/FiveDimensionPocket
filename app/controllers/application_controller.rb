class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, 
              with: :record_not_found
  layout :layout_by_resource
  before_action :article_new, :article_all, :create_tags_menu

  def record_not_found
    render file: 'public/404.html', 
           status: 404, 
           layout: false
  end

  def extractor_fail
    render file: 'public/500_extractor_fail.html',
           status: 500,
           layout: false
  end

  private
  def article_new
    @article = current_user ? current_user.articles.new(favorite: false, read: false) : Article.new(favorite: false, read: false)
  end

  def article_all
    @articles = Article.all
  end
 
  def layout_by_resource
    if devise_controller? && resource_name == :user && action_name == 'new'
      "devise"
    end
  end

  def create_tags_menu
    @user_tags = current_user.tags
  end
end
