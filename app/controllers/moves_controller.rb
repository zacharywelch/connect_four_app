class MovesController < ApplicationController
  before_action :set_game
  respond_to :html

  def create
    @move = @game.drop(move_params[:column], move_params[:value])
    respond_with @move, location: -> { game_path(@game) }
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def move_params
    params.require(:move).permit(:column, :value)
  end
end
