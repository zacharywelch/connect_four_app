class Board
  attr_reader :spaces
  BLANK = ' '
  
  def initialize(lines = nil)
    @spaces = Array.new(6) { Array.new(7, BLANK) }
    unless lines.nil?
      6.times do |row|
        7.times do |column|
          @spaces[row][column] = lines[row][column]
        end
      end
    end
  end

  def move(row, column, disc)
    @spaces[row][column] = disc
  end

  def drop(column, disc)
    row, column = next_available_space(column)
    @spaces[row][column] = disc
  end

  def draw?
    spaces.flatten.none? { |space| space == BLANK }
  end

  def winner
    vertical_winner || horizontal_winner || diagonal_winner
  end

  def winner?
    winner.present?
  end

  def draw
    puts "\n"
    spaces.reverse.each do |row|
      print "|"
      row.each { |column| print "#{column}|" }
      puts "\n"
    end
    puts " 1 2 3 4 5 6 7 "
  end

  def next_available_space(column)
    spaces.each_with_index do |space, row|
      break row, column if space[column] == BLANK
    end
  end

  alias :rows :spaces
  
  def columns
    rows.transpose
  end

  def copy
    self.class.new(spaces)
  end

  private

  def horizontal_winner
    ConnectFourMatcher.new(rows).winner
  end

  def vertical_winner
    ConnectFourMatcher.new(columns).winner
  end

  def diagonal_winner
    ConnectFourMatcher.new(diagonals).winner
  end

  # based on http://stackoverflow.com/questions/2506621/ruby-getting-the-diagonal-elements-in-a-2d-array
  def diagonals
    left, right = [], []
    pad = spaces.size - 1
    spaces.each do |row|
      left << ([nil] * (spaces.size - pad)) + row + ([nil] * pad)
      right << ([nil] * pad) + row + ([nil] * (spaces.size - pad))
      pad -= 1
    end
    left.transpose.map(&:compact) + right.transpose.map(&:compact)
  end  
end
