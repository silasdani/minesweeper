class PagesController < ApplicationController
  def home
    @mine = Mine.new
    @mines = Mine.all
  end
end
