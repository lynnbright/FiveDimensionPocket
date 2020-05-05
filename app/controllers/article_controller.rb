class ArticleController < ApplicationController 

  def index
    @articles = Article.all 
  end

  def create
    response = HTTParty.get("https://extractorapi.com/api/v1/extractor/?apikey=e3e6d4d35cbf7ecc564ed3d42fca87a75cc242dc&url=#{url_params[:link]}")
    response_hash = JSON.parse(response.body)

    # @article = Article.new(url: url_params)
    # @article.title = response_hash["title"]
    # @article.content = response_hash["text"]
    # @article.link = response_hash["domain"]
    # @article.

    if response.code == 200
      @article.assign_attributes({
        user_id: current_user 
        link: url_params[:link],
        title: response_hash['title'],
        content: response_hash['text'],
      })
      @article.save
      render :index
    else
      # alert: '請輸入正確網址'
    end

  end



  private
  def url_params
    params.require(:article).permit(:link) 
  end
end