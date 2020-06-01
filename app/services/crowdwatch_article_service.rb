class CrowdwatchArticleService < ArticleSendApiService
  
  @title = page.xpath("//title").text
  @ogimage_address = page.xpath('/html/head/meta[@property="og:image"]/@content').text
  @short_description = page.xpath('/html/head/meta[@property="og:description"]/@content').text.split('').first(50).join('')
  @clean_html = page.xpath("//div[@class='inner-post-entry entry-content']").to_s.gsub!("\n","").gsub!("\t","").gsub!("\r","").gsub!(/\"/, '\'')
  @text = page.xpath("//div[@class='inner-post-entry entry-content']").text.gsub!("\n","").gsub!("\t","").gsub!("\r","")
  @domain = @article_url.match(/^(?:https?:)?(?:\/\/)?(?:[^@\n]+@)?(?:www\.)?([^:\/\n]+)/).to_s

end