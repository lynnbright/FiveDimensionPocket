class WelcomeController < ApplicationController 
  skip_before_action :create_tags_menu
  
  def index
    render :index, layout: false
  end
end