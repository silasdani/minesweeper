class Mine < ApplicationRecord
  validates :name, :email, presence: true

  def map
    Marshal.load(self[:map])
  end

  before_create :generate_map

  def generate_map
    # generate a minesweeper sized n x m with random mines
    n = self.rows
    m = self.columns
    mines = self.mines
    matrix = Array.new(n) { Array.new(m) { 0 } }
    mines.times do
      x = rand(n)
      y = rand(m)
      matrix[x][y] = 1
    end

    self.map = Marshal.dump(matrix)
  end
end
