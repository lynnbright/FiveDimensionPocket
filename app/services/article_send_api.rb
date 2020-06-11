require 'nokogiri'
require 'open-uri'

class ArticleSendApi

  SITE_MAPPING = {
    five_x_ruby: '5xruby.tw',
    crowd_watch: 'crowdwatch.tw',
    medium: 'medium.com',
    womany: 'womany.net',
    it_help: 'ithelp.ithome.com.tw',
    stack_over_flow: 'stackoverflow.com',
  }

  def initialize(url)
    @url = url
    @channel = get_channel
    @site_key = get_site_key
  end

  
  def perform
    if @site_key.blank? || @channel == :extractor
      response = HTTParty.get("https://extractorapi.com/api/v1/extractor/?apikey=#{ENV['extractor_key']}&url=#{@url}&fields=domain,title,date_published,images,videos,clean_html,html")
      response_hash = JSON.parse(response.body)

      raise 'Response Fail, No Text!' if response_hash['text'].blank?
      @short_description = response_hash['text'].split('').first(50).join('')
      
      #萃取出 og:image 圖片位址
        meta_ogimage = response_hash['html'].gsub(/\"/, '\'').match(/<meta(?: [^>]+)? property='og:image'[^>]*>/).to_s
        @ogimage_address = meta_ogimage.match(/(?<=content=').*(\.png|\.jpg)/).to_s  #"https://xxxx... .jpg"
    
      #萃取出 clean_html 的 <p>內文</p> 區塊
        @clean_html = response_hash['clean_html'].gsub!(/\"/, '\'')
        @clean_content = @clean_html.match(/<p[^>]*>[\w|\W]*<\/i>/).to_s
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
    
    else
      klass = "ArticleSendApi::Nokogiri::#{@site_key.to_s.camelize}".constantize
      obj = klass.new(@url)
      obj.perform
    end
    rescue 
      { api_status: 'extractor_fail' }
  end


  private

  # return: :nokogiri, :extractor
  def get_channel  
    site_mapping_values = SITE_MAPPING.values.map { |domain| @url.match(domain) } #['5xruby.tw', 'crowdwatch.tw'....]
    site_mapping_values.compact.blank? ? :extractor : :nokogiri
  end

  def site_domain
    return @site_domain if @site_domain
    @site_domain = @url.match(/^(?:https?:)?(?:\/\/)?(?:[^@\n]+@)?(?:www\.)?([^:\/\n]+)/).to_s
  end

  def get_site_key
    SITE_MAPPING.find do |k, v|
      return k if @url.match(/#{v}/)
    end
  end
end