class Api::V1::ChartsController < ApplicationController
  before_action :authenticate_user!

  def tag
    user = User.find_by(id: current_user.id)
    tags = user.tag_chart
    render json: {tags: tags}
  end

  def read
    user = User.find_by(id: current_user.id)
    read = user.read_chart
    render json: {read: read}
  end

  def read_rate
    user = User.find_by(id: current_user.id)
    read_rate = user.read_chart
    render json: {read_rate: read_rate}
  end

end
