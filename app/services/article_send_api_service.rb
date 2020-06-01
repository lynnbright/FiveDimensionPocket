require 'nokogiri'
require 'open-uri'

class ArticleSendApiService

  def initialize(article_url)
    @article_url = article_url
  end

  def perform(retry_times = 0)

    site_collection = ["群眾觀點", "為你自己學 Ruby on Rails", "iT 邦幫忙::一起幫忙解決難題，拯救 IT 人的一天", "Medium", "女人迷 Womany", "CNN", "Stack Overflow"]
    page = Nokogiri::HTML(open(@article_url))
    site_name = page.xpath('//meta[@property="og:site_name"]/@content').text
    
    #若包含則開始用 Nokogiri 解析出需要的文章info(以群眾觀點及 Womany 測試)
    if site_Collection.include?(site_name)
      #call sitename 的 service 
      {
        nokogiri_success: 'nokogiri_success', 
        extract_data: {
          title: @title,
          ogimage_address: @ogimage_address,
          short_description: @short_description,
          clean_html: @clean_html,
          clean_content: @clean_html, 
          content: @text,
          domain: @domain
        }
      }


    #若 site_name 不包含在陣列中，則使用 api 取回文章資訊  
    else  
      response = HTTParty.get("https://extractorapi.com/api/v1/extractor/?apikey=#{ENV['extractor_key']}&url=#{@article_url}&fields=domain,title,date_published,images,videos,clean_html,html")
      response_hash = JSON.parse(response.body)

      raise 'No Text!' if response_hash['text'].blank?
      @short_description = response_hash['text'].split('').first(50).join('')
      
      #萃取出 og:image 圖片位址
      meta_ogimage = response_hash['html'].gsub(/\"/, '\'').match(/<meta(?: [^>]+)? property='og:image'[^>]*>/).to_s
      @ogimage_address = meta_ogimage.match(/(?<=content=').*(\.png|\.jpg)/).to_s  #"https://xxxx... .jpg"
    
      #萃取出 clean_html 的 <p>內文</p> 區塊
      if response_hash['clean_html'] != nil
        @clean_html = response_hash['clean_html'].gsub!(/\"/, '\'')
        @clean_content = @clean_html.match(/<p[^>]*>[\w|\W]*<\/i>/).to_s
      else
        #五倍網站使用 extractor api clean_html 為 null，故針對五倍網站 DOM 結構的另寫萃取方式
        url = response_hash['url']
        doc = Nokogiri::HTML(open( url ))

        result = doc.xpath("//div[@class='post-main-content mb-3 mb-md-5']").to_s
        clean_n_res = result.gsub!("\n","")
        @clean_content = clean_n_res.gsub(/\"/, '\'')
        @clean_html = nil
      end
      
      {
        api_success: true, 
        data: response_hash,
        extract_data: {
          clean_html: @clean_html,
          clean_content: @clean_content,
          ogimage_address: @ogimage_address,
          short_description: @short_description 
        }
      }
    end
      rescue
        if retry_times < 1
          retry_times += 1
          retry
        else
          { success: false }
        end
      end
 
end