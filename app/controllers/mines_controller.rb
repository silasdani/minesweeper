class MinesController < ApplicationController
  before_action :set_mine , only: [:edit, :update, :show]

  def index
    @mines = Mine.all
  end

  def show; end

  def new
    @mine = Mine.new
  end

  def create
    @mine = Mine.new(mine_params)
    if @mine.save
      redirect_to edit_mine_path(@mine)
    else
      render :new
    end
  end

  def edit
    set_mine
  end

  def update
    set_mine
    if @mine.update(mine_params)
      redirect_to edit_mine_path(@mine)
    else
      render :edit
    end
  end

  private

  def set_mine
    @mine = Mine.find(params[:id])
  end

  def mine_params
    params.require(:mine).permit(:name, :email, :map, :rows, :columns, :mines)
  end
end
