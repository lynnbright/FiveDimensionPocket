class Api::V1::ChartsController < ApplicationController
  before_action :authenticate_user!

  def tag
    user = User.find_by(id: current_user.id)
    tags = user.tag_chart
    render json: {tags: tags}
  end

  def readed
    user = User.find_by(id: current_user.id)
    readed = user.readed_chart
    render json: {readed: readed}
  end

end
