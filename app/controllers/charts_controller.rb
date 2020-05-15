class ChartsController < ApplicationController
  before_action :authenticate_user!
  def index 
  end

  def tagchart 
    # tags = Tag.where(user_id: current_user.id)
    user = User.find_by(id: current_user.id)
    tags = user.tag_chart
    render json: {tags: tags}
  end

end
