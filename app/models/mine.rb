require 'json'

class Mine < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  EMPTY_SPOT = 0
  REVEALED_SPOT = -1
  BOMB_SPOT = 9

  validates :name, :mines, :rows, :columns, :email, presence: true
  validates_format_of :email, with: EMAIL_REGEX
  validates :mines, numericality: { only_integer: true, greater_than: 0 }
  validates :rows, :columns, numericality: { only_integer: true, greater_than: 0 }

  scope :last_created_mines, ->(n) { order(created_at: :desc).limit(n) }

  # each value in the matrix can be:
  # 0 - empty spot
  # 1-8 - number of bombs around
  # 9 - bomb
  def map
    self[:map].present? ? JSON.parse(self[:map]) : [[]]
  end

  before_create :generate_map

  def generate_map
    n = rows
    m = columns
    mines = self.mines > n * m ? n * m : self.mines
    matrix = Array.new(n) { Array.new(m) { 9 } }

    adj = []
    (0..(n - 1)).each do |i|
      (0..(m - 1)).each do |j|
        adj << [i, j]
      end
    end

    adj.shuffle!

    (0..(mines - 1)).each do |i|
      matrix[adj[i][0]][adj[i][1]] = 0
    end

    self.map = JSON.dump(matrix)
  end

  def reveal(row, column)
    row = row.to_i
    column = column.to_i

    matrix = map
    n = rows
    m = columns

    if matrix[row][column] == BOMB_SPOT
      matrix.each do |row|
        row.each_with_index do |column, index|
          row[index] = REVEALED_SPOT if column == BOMB_SPOT
        end
      end
    else
      bombs_around_count = 0
      (row - 1..row + 1).each do |i|
        (column - 1..column + 1).each do |j|
          bombs_around_count += 1 if i >= 0 && i < n && j >= 0 && j < m && matrix[i][j] == BOMB_SPOT
        end
      end

      matrix[row][column] = bombs_around_count
    end

    self.map = JSON.dump(matrix)
    save
  end
end
