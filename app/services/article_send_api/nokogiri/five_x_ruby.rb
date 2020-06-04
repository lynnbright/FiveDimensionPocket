class ArticleSendApi
  module Nokogiri
    class FiveXRuby < Base
      
      def initialize(url)
        @url = url
        @page = ::Nokogiri::HTML(open(@url))  
        @site_domain = @url.match(/^(?:https?:)?(?:\/\/)?(?:[^@\n]+@)?(?:www\.)?([^:\/\n]+)/).to_s
      end

      def perform
        @title = @page.xpath('//title').text
        @ogimage_address = 'https://i.imgur.com/kKtW46A.jpg'
        @clean_html = @page.xpath("//div[@class='post-main-content mb-3 mb-md-5']").to_s.gsub("\n", '').gsub(/\"/,'\'')
        @text = @page.xpath("//div[@class='post-main-content mb-3 mb-md-5']").text.gsub("\n",'').gsub(/\"/, '\'')
        @short_description = @text.split('').first(50).join('')
        {
          nokogiri_success: 'nokogiri_success', 
          extract_data: {
            title: @title,
            ogimage_address: @ogimage_address,
            short_description: @short_description,
            clean_html: @clean_html,
            clean_content: @clean_html, 
            content: @text,
            domain: @site_domain
          }
        }
      end
    end
  end
end