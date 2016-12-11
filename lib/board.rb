class Board
  attr_reader :rows, :columns, :spaces
  BLANK = ' '    
  
  def initialize(default = BLANK)
    @rows, @columns = 6, 7
    @spaces = Array.new(rows) { Array.new(columns, default) }
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

  def winner?
    winning_row? || winning_column? || winning_diagonal?
  end

  def to_s
    puts "\n"
    spaces.reverse.each do |row|
      print "|"
      row.each { |column| print "#{column}|" }
      puts "\n"
    end
    puts " 1 2 3 4 5 6 7 "
  end

  alias :draw :to_s

  def next_available_space(column)
    spaces.each_with_index do |space, row|
      break row, column if space[column] == BLANK
    end
  end

  private

  def winning?(lines)
    lines.any? { |line| line.join.match(/(\w)\1{3}/) }
  end

  def winning_row?
    winning? spaces
  end

  def winning_column?
    winning? spaces.transpose
  end

  def winning_diagonal?
    winning? diagonals
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
