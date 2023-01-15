class MinesController < ApplicationController
  before_action :set_mine, only: [:edit, :update, :show]

  def index
    @page = 'Mines'
    @pagy, @mines = pagy(Mine.all)
  end

  def show; end

  def new
    @page = 'Home'
    @mine = Mine.new
    @mines = Mine.last_created_mines(10)
  end

  def create
    @mine = Mine.new(mine_params)
    @mines = Mine.last_created_mines(10)

    respond_to do |format|
      if @mine.save
        format.html { redirect_to mine_url(@mine), notice: 'Board was successfully created.' }
        format.json { render :show, status: :created, location: @mine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mine.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @page = 'Edit Mine'
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
