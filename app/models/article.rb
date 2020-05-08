require 'open-uri'

class Article < ApplicationRecord
  has_many :article_tags
  has_many :tags, through: :article_tags
  belongs_to :user
  has_many_attached :article_images

  #拿到存到本地端後的圖片位址
  def images
    article_images.map do |image|
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) 
    end  
  end

  #把網路上拿到的圖片網址，存到 active_storage 
  def images=(images = []) 
    files = images.map do |url|   
      { io: open(url), filename: 'image.jpg' }
      rescue OpenURI::HTTPError => e
        if e.message == '404 Not Found'
          { io: open("https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_relaxing_on_patio_other/1800x1200_cat_relaxing_on_patio_other.jpg"), filename: 'image.jpg' }
        end
      end  
    self.article_images.attach(files)
  end
end
