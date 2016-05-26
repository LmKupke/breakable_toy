class HomeController < ApplicationController
  def index
    @hide_nav_bar = true
    @current_page = "home-page"
  end
end
