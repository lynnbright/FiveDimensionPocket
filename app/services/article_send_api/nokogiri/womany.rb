class ArticleSendApi
  module Nokogiri
    class Womany < Base
      
      def initialize(url)
        @url = url
        @page = ::Nokogiri::HTML(open(@url))
        @site_domain = @url.match(/^(?:https?:)?(?:\/\/)?(?:[^@\n]+@)?(?:www\.)?([^:\/\n]+)/).to_s
      end

      def perform
        @title = @page.xpath("//title").text
        @ogimage_address = @page.xpath('/html/head/meta[@property="og:image"]/@content').text
        @short_description = @page.xpath('/html/head/meta[@name="description"]/@content').text
        @clean_html = @page.xpath('//section[@class="article-body"]').to_s.gsub!("\n","").gsub!("\r","").gsub!(/\"/, '\'')
        @text = @page.xpath('//section[@class="article-body"]').text.gsub!("\n","").gsub!("\r","")
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