class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @articles_json = current_user.articles.to_json
    @articles_solve_nplus1 = Article.with_attached_article_images   #解決 N+1 問題
    @articles = current_user.articles.where.not(content: nil, title: nil, link: nil).order(id: :desc)
  end

  def create
    response = HTTParty.get("https://extractorapi.com/api/v1/extractor/?apikey=#{ENV['extractor_key']}&url=#{url_params[:link]}&fields=domain,title,author,date_published,images,videos,clean_html")
    response_hash = JSON.parse(response.body)
    clean_html = response_hash['clean_html'].gsub!(/\"/, '\'')

    if response.code == 200
      @article.assign_attributes({
        user_id: current_user.id,
        link: url_params[:link],
        title: response_hash['title'],
        content: response_hash['text'],
        domain: response_hash['domain'],
        images: response_hash['images'],
        clean_html: clean_html
      })
      # @article.images = response_hash['images']
      @article.save
      #render 之前要先把 input value 清空
      redirect_to articles_path
    else
      flash[:notice] = '請輸入正確網址'
    end
  end



  private
  def url_params
    params.require(:article).permit(:link, article_images: []) 
  end
end