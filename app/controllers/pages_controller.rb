class PagesController < ApplicationController
  def home
    @page = "Home"
    @mine = Mine.new
    @mines = Mine.last_created_mines(10)
  end
end
