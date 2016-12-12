class MovePresenter
  attr_reader :game, :row, :column
  
  def initialize(attributes = {}, template)
    @game = attributes[:game]
    @row = attributes[:row]
    @column = attributes[:column]
    @template = template
  end

  def move
    @move ||= game.move_at(row, column)
  end

  def available?
    move.nil? && !game.over?
  end

  def color
    value_to_color(move.value) if move.present?
  end

  def value
    return move.value if move.present?
    return if game.over?
    return 'x' if blue_player?
    return 'o'
  end

  def to_s
    @template.render partial: 'moves/move', object: self
  end

  private

  def blue_player?
    game.turn == game.blue_player
  end

  def value_to_color(value)
    case value
    when 'x' then 'bg-primary'
    when 'o' then 'bg-danger'
    else nil
    end
  end
end
