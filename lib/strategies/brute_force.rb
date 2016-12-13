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
      open_moves.inject({}) do |scores, column|
        scores[column] = ScoringSimulator.new(board, symbol, depth)
                                         .score(column)
        scores
      end
    end

    def open_moves
      board.columns.each_with_index.map do |line, column| 
        column if line.join.match(/(\s)/)
      end.compact
    end

    class ScoringSimulator
      attr_reader :board, :symbol, :depth
      
      def initialize(board, symbol, depth)
        @board, @symbol, @depth = board.copy, symbol, depth
      end

      def score(column)
        board.drop(column, symbol)
        return winner_score if winner.present?
        return average_score if intelligent_scoring?
        return 0
      end

      private

      def winner_score
        winner == symbol ? 1 : -1
      end

      def winner
        @winner ||= board.winner
      end

      def intelligent_scoring?
        depth > 1
      end

      def average_score
        opponent_scores.reduce(:+).to_f / opponent_scores.length * -1
      end

      def opponent
        symbol == 'o' ? 'x' : 'o'
      end

      def opponent_scores
        @opponent_scores ||= BruteForce.new(board, depth - 1)
                                       .scores(opponent)
                                       .values
      end
    end
  end
end
