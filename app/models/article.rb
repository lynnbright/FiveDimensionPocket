require 'open-uri'

class Article < ApplicationRecord
  has_many :article_tags
  has_many :tags, through :article_tags
  default_scope { where.not(created_at: nil).order(id: :desc)}
  belongs_to :user

  #圖片儲存
  has_one_attached :article_cover
  before_save :grab_cover

  private
  def grab_cover
    file = open("https://womany.net/cdn-cgi/image/w=800,fit=scale-down,f=auto/https://castle.womany.net/images/content/pictures/62832/womany_161114_4496_6_EhMdP_1503483761-16149-5365.jpg") 
    self.article_cover.attach(io: file, filename: 'cover.jpg', content_type: 'image/jpg')
  end
end
