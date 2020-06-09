class ChartsController < ApplicationController
  before_action :authenticate_user!
  
  def index    
    user = User.find_by(id: current_user.id)
    @statistics_data = Chart.new(user)
  end
end