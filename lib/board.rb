class Board
  attr_reader :rows, :columns, :spaces
  BLANK = ' '
  
  def initialize(lines = nil)
    @rows, @columns = 6, 7
    @spaces = Array.new(rows) { Array.new(columns, BLANK) }
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

  def move_scores_for(disc, depth)
    valid_moves.inject({}) do |scores, column|
      simulation = Board.new(spaces)
      simulation.drop(column, disc)
      if simulation.winner?
        scores[column] = simulation.winner == disc ? 1 : -1
      elsif depth > 1
        opponent = (disc == 'o' ? 'x' : 'o')
        next_move_scores = simulation.move_scores_for(opponent, depth - 1).values
        average = next_move_scores.reduce(:+).to_f / next_move_scores.length
        scores[column] = -1 * average
      else
        scores[column] = 0
      end
      scores
    end
  end

  private

  def horizontal_winner
    ConnectFourMatcher.new(spaces).winner
  end

  def vertical_winner
    ConnectFourMatcher.new(spaces.transpose).winner
  end

  def diagonal_winner
    ConnectFourMatcher.new(diagonals).winner
  end

  def valid_moves
    spaces.transpose.each_with_index.map do |line, column| 
      column if line.join.match(/(\s)/)
    end.compact
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
