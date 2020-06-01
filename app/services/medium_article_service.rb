class MediumArticleService < ArticleSendApiService

  def initialize()
  end

  def perform

    #do something
    @title = page.xpath("//title").text
    @ogimage_address = page.xpath('/html/head/meta[@property="og:image"]/@content').text
    @short_description = page.xpath('/html/head/meta[@name="description"]/@content').text.split('').first(50).join('')
    @clean_html = page.xpath("//article//p").to_s.gsub!("\n","").gsub!(/\"/, '\'')
    @text = page.xpath("//article//p").text
    @domain = @article_url.match(/^(?:https?:)?(?:\/\/)?(?:[^@\n]+@)?(?:www\.)?([^:\/\n]+)/).to_s
  end

end