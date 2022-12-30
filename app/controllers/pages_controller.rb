class PagesController < ApplicationController
  def home
    @page = "Home"
    @mine = Mine.new
    @mines = Mine.all
  end
end
