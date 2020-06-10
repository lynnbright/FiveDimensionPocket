class Chart
  def initialize(user)        
    @user = user
  end

  def read_rate
    count = @user.articles.where(read: true).count
    if count > 0
      read_rate = @user.articles.where(read: true).count.fdiv(@user.articles.count) *100
      read_rate.floor
    else
      read_rate = 0
    end
  end
  
  def total_articles
    @user.articles.count
  end

  def total_read
    @user.articles.where(read: true).count
  end

  def total_unread
    @user.articles.where(read: false).count
  end

end