class CreateArticleService < ActiveRecord::Base

  def initialize(article_url, current_user)
    @article_url = article_url
    @current_user = current_user
  end

  def perform
    response = HTTParty.get("https://extractorapi.com/api/v1/extractor/?apikey=e3e6d4d35cbf7ecc564ed3d42fca87a75cc242dc&url=#{@article_url}&fields=domain,title,author,date_published,images,videos,clean_html,html")
    response_hash = JSON.parse(response.body)
    short_description = response_hash['text'].split('').first(50).join('')
    
    #萃取出 og:image 圖片位址
    meta_ogimage = response_hash['html'].gsub(/\"/, '\'').match(/<meta(?: [^>]+)? property='og:image'[^>]*>/).to_s
    ogimage_address = meta_ogimage.match(/(?<=content=').*(\.png|\.jpg)/).to_s  #"https://xxxx... .jpg"
   
    #萃取出 clean_html 的 <p>內文</p> 區塊
    clean_html = response_hash['clean_html'].gsub!(/\"/, '\'') || 'null'
    clean_content = clean_html.match(/<p[^>]*>[\w|\W]*<\/i>/).to_s
    
    if response.code == 200
      @article.assign_attributes({
        user_id: @current_user.id,
        link: @article_url,
        title: response_hash['title'],
        content: response_hash['text'],
        domain: response_hash['domain'],
        images: response_hash['images'] << ogimage_address,
        clean_html: clean_html,
        clean_content: clean_content,
        short_description: short_description,
      })
      # @article.images = response_hash['images']
      @article.save
      redirect_to articles_path
    else
      flash[:notice] = '請輸入正確網址'
    end
  end
end