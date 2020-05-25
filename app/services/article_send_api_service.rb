class ArticleSendApiService

  def initialize(article_url)
    @article_url = article_url
  end

  def perform(retry_times = 0)
    response = HTTParty.get("https://extractorapi.com/api/v1/extractor/?apikey=#{ENV['extractor_key']}&url=#{@article_url}&fields=domain,title,date_published,images,videos,clean_html,html")
    response_hash = JSON.parse(response.body)

    # raise 'No Text!' if response_hash['text'].blank?
    @short_description = response_hash['text'].split('').first(50).join('')
    
    #萃取出 og:image 圖片位址
    meta_ogimage = response_hash['html'].gsub(/\"/, '\'').match(/<meta(?: [^>]+)? property='og:image'[^>]*>/).to_s
    @ogimage_address = meta_ogimage.match(/(?<=content=').*(\.png|\.jpg)/).to_s  #"https://xxxx... .jpg"
   
    #萃取出 clean_html 的 <p>內文</p> 區塊
    @clean_html = response_hash['clean_html'].gsub!(/\"/, '\'') || 'null'
    @clean_content = @clean_html.match(/<p[^>]*>[\w|\W]*<\/i>/).to_s
    
    {
      success: true, 
      data: response_hash,
      extract_data: {
        clean_html: @clean_html,
        clean_content: @clean_content,
        ogimage_address: @ogimage_address,
        short_description: @short_description 
      }
    }
  rescue
    if retry_times < 1
      retry_times += 1
      retry
    else
      { success: false }
    end
  end
end