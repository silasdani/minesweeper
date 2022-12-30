class MinesController < ApplicationController
  before_action :set_mine , only: [:edit, :update, :show]

  def index
    @page = "Mines"
    @mines = Mine.all
  end

  def show; end

  def new
    @page = "New Mine"
    @mine = Mine.new
  end

  def create
    @mine = Mine.new(mine_params)
    if @mine.save
      redirect_to edit_mine_path(@mine)
    else
      redirect_to root_path, alert: @mine.errors.full_messages.to_s
    end
  end

  def edit
    @page = "Edit Mine"
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
