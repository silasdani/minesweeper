require 'json'

class Mine < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, :mines, :rows, :columns, :email, presence: true
  validates_format_of :email, with: EMAIL_REGEX
  validates :mines, numericality: { only_integer: true, greater_than: 0 }
  validates :rows, :columns, numericality: { only_integer: true, greater_than: 0 }

  scope :last_created_mines, ->(n) { order(created_at: :desc).limit(n) }

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
end
