class MovesController < ApplicationController
  before_action :set_game
  respond_to :html

  def create
    @move = @game.moves.new(move_params)
    @move.save
    respond_with @move, location: -> { game_path(@game) }
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def move_params
    params.require(:move).permit(:row, :column, :value)
  end
end
