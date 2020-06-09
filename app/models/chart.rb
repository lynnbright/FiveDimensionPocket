class Chart
  def initialize(user)        
    @user = user
  end

  def read_rate
    read_rate = @user.articles.where(read: true).count.fdiv(@user.articles.count) *100
    read_rate.floor
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