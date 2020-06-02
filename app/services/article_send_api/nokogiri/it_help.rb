class ArticleSendApi 
  module Nokogiri
    class ItHelp < Base

      def initialize(url)
        @url = url
        @page = ::Nokogiri::HTML(open(@url))
        @site_domain = @url.match(/^(?:https?:)?(?:\/\/)?(?:[^@\n]+@)?(?:www\.)?([^:\/\n]+)/).to_s
      end

      def perform
        @title = @page.xpath("//title").text
        @ogimage_address = 'https://i.imgur.com/e1HtnvV.jpg'
        @short_description = @page.xpath('/html/head/meta[@property="og:description"]/@content').text
        @clean_html = @page.xpath("//div[@class='markdown']").to_s.gsub!("\n","").gsub!(/\"/, '\'')
        @text = @page.xpath("//div[@class='markdown']").text.gsub!("\n","").gsub(/\"/, '\'')
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