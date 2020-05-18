class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles_solve_nplus1 = Article.with_attached_article_images   #解決 N+1 問題
    @articles = current_user.articles.order(id: :desc)
  end

  def show
    @article = Article.find(params[:id])
  end


  def create
    create_article()
  end


  private
  def url_params
    params.require(:article).permit(:link, article_images: []) 
  end


  def create_article
    response = HTTParty.get("https://extractorapi.com/api/v1/extractor/?apikey=#{ENV['extractor_key']}&url=#{url_params[:link]}&fields=domain,title,author,date_published,images,videos,clean_html")
    response_hash = JSON.parse(response.body)
    clean_html = response_hash['clean_html'].gsub!(/\"/, '\'') || 'null'
    clean_content = clean_html.match(/<p[^>]*>[\w|\W]*<\/i>/).to_s
    short_description = response_hash['text'].split('').first(50).join('')

    if response.code == 200
      @article.assign_attributes({
        user_id: current_user.id,
        link: url_params[:link],
        title: response_hash['title'],
        content: response_hash['text'],
        domain: response_hash['domain'],
        images: response_hash['images'],
        clean_html: clean_html,
        clean_content: clean_content,
        short_description: short_description
      })
      # @article.images = response_hash['images']
      @article.save
      redirect_to articles_path
    else
      flash[:notice] = '請輸入正確網址'
    end
  end
end