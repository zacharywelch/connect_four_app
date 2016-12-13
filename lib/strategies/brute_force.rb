module Strategies
  class BruteForce        
    attr_reader :board, :depth
    
    def initialize(board, depth = 1)
      @board = board
      @depth = depth
    end

    def best_move(symbol)
      scores(symbol).sort_by { |column, score| score }.last[0]
    end

    def scores(symbol)
      valid_moves.inject({}) do |scores, column|
        test = board.copy
        test.drop(column, symbol)
        if test.winner?
          scores[column] = test.winner == symbol ? 1 : -1
        elsif depth > 1
          opponent = (symbol == 'o' ? 'x' : 'o')
          next_move_scores = BruteForce.new(test, depth - 1).scores(opponent).values
          average = next_move_scores.reduce(:+).to_f / next_move_scores.length
          scores[column] = -1 * average
        else
          scores[column] = 0
        end
        scores
      end
    end

    def valid_moves
      board.columns.each_with_index.map do |line, column| 
        column if line.join.match(/(\s)/)
      end.compact
    end
  end
end
