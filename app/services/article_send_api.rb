require 'nokogiri'
require 'open-uri'

class ArticleSendApi

  #調整為 domain name
  SITE_COLLECTION = [
    "群眾觀點",
    "為你自己學 Ruby on Rails",
    "iT 邦幫忙::一起幫忙解決難題，拯救 IT 人的一天",
    "Medium",
    "女人迷 Womany",
    "CNN",
    "Stack Overflow",
    '五倍紅寶石｜專業程式教育機構｜實戰轉職訓練'
  ]

  SITE_MAPPING = {
    five_x_ruby: '5xruby.tw'
  }

  def initialize(url)
    @url = url
    @channel = get_channel
    @site_key = get_site_key
  end

  def perform
    if @site_key.blank? || @channel == :extractor
    else
      klass = "ArticleSendApi::Nokogiri::#{@site_key.to_s.camelize}".constantize
      obj = klass.new(@url)
      obj.perform
    end
  end

  private

  # return: :nokogiri, :extractor
  def get_channel
    SITE_COLLECTION.include?(site_name) ? :nokogiri : :extractor
  end

  def site_name
    return @site_name if @site_name

    page = ::Nokogiri::HTML(open(@url))
    @site_name = page.xpath('//meta[@property="og:site_name"]/@content').text
  end

  def get_site_key
    SITE_MAPPING.find do |k, v|
      return k if @url.match(/#{v}/)
    end
  end
end