class Mine < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, :mines, :rows, :columns, :email, presence: true
  validates_format_of   :email, with: EMAIL_REGEX
  validates :mines, numericality: { only_integer: true, greater_than: 0 }
  validates :rows, :columns, numericality: { only_integer: true, greater_than: 0 }

  def map
    self[:map].present? ? Marshal.load(self[:map]) : [[]]
  end

  before_create :generate_map

  def generate_map
    n = self.rows
    m = self.columns
    mines = self.mines > n * m ? n * m : self.mines
    matrix = Array.new(n) { Array.new(m) { 0 } }

    mines.times do
      x = rand(n)
      y = rand(m)

      while matrix[x][y] == 1
        x = rand(n)
        y = rand(m)
      end

      matrix[x][y] = 1
    end

    self.map = Marshal.dump(matrix)
  end
end
