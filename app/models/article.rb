require 'open-uri'
require 'base64'

class Article < ApplicationRecord
  has_many :article_tags
  has_many :tags, through: :article_tags
  belongs_to :user
  # belongs_to :user_last_article
  has_many_attached :article_images
  
  validates :content, presence: true
  validates :link, presence: true

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

  def changed_by(user)
    user.articles.include?(self) 
  end

  def tag_list=(selected_tags)  
    user = User.find_by(id: self.user_id)
    selected_tags.each do |selected_tag|       
      user_tag = user.tags.find_by(name: selected_tag)
      if user_tag
        article_tag = self.tags.find_by(id: user_tag.id)
        # 如果選項在article.tag沒有，新增關聯，counter++
        if article_tag.nil?
          self.tags << user_tag
          user_tag.increment!(:counter)
        end
      else # 如果User的tags沒有，全新新增，counter=1        
        add_tag = Tag.new(user_id: self.user_id, name: selected_tag, counter: 1)
        self.tags << add_tag      
      end
    end
    # self.tags有但selected沒有，刪除關聯，counter--
    self.tags.each do |article_tag|
      unless selected_tags.include?(article_tag.name)
        self.article_tags.find_by(tag_id: article_tag.id).destroy
        article_tag.decrement!(:counter)
      end
    end    
  end

  def tag_list
    self.tags.map {|tag| tag[:name]}
  end

end
