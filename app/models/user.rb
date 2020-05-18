require 'open-uri'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :tags
  has_many :articles
  has_many :follow_lists
  has_one_attached :avatar


  after_commit :add_default_avatar, on: [:create, :update]

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "50x50!").processed 
    else
      '/default_profile.jpg'
    end
  end


  def tag_chart
    all_tag = self.tags.select("name","counter")
  end

  def readed_chart
    read_record = self.articles
                      .where(readed: true)
                      .where("readed_at >= :beginning_of_week and 
                              readed_at <= :end_of_week ",
                              beginning_of_week: Time.current.beginning_of_week, 
                              end_of_week: Time.current.end_of_week)
                      .group("DATE(readed_at)").count            
  end

  private

  def self.from_omniauth(access_token)    
    data = access_token.info
    file = open(data['image'])
    user = User.where(email: data['email']).first
    unless user
        user = User.create(name: data['name'],
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
        # 把api收到的圖片存入
        user.avatar.attach(io: file, filename: 'profile.jpg', content_type: 'image/jpg')
    end
    user
  end

  def add_default_avatar
    unless avatar.attached?
      self.avatar.attach(
      io: File.open(
        Rails.root.join(
          'app', 'assets', 'images', 'default_profile.jpg'
          )
        ), 
        filename: 'default_profile.jpg', 
        content_type: 'image/jpg'
      )
    end
  end
end
