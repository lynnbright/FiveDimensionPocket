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
  has_many :user_last_articles
  has_many :searches
  has_one_attached :avatar
  # 產生亂數的token
  has_secure_token :auth_token

  after_commit :add_default_avatar, on: [:create, :update]

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "50x50!").processed 
    else
      '/default_profile.jpg'
    end
  end

  def tag_chart
    all_tag = self.tags.select("name","counter").where("counter > 0")
  end

  def read_chart
    read_record = self.articles
                      .where(read: true)
                      .where("read_at >= :fourteen_days_before and 
                              read_at <= :today ",
                              fourteen_days_before: Time.now - 14.days, 
                              today: Time.current)
                      .group("DATE(read_at)").count        
    date_hash = Hash[(14.days.ago.to_date..Date.today).collect { |date| [date, 0] } ]
    date_hash.keys.each { |date|
      read_record.keys.each { |record_date|
        if date == record_date
          date_hash[date] = read_record[record_date]
        end
      }
    }
    date_hash
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
