class MovesController < ApplicationController
  before_action :set_game
  respond_to :html

  def create
    @move = @game.moves.new(move_params)
    if @move.save
      redirect_to @game, notice: 'Move successfully created.'
    else
      render 'games/show'
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def move_params
    params.require(:move).permit(:row, :column, :value)
  end
end
