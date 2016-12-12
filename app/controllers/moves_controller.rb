class MovesController < ApplicationController

  def create
    @game = Game.find(params[:game_id])
    @move = @game.drop(move_params[:column], move_params[:value])
    respond_to do |format|
      format.js
      format.html { redirect_to @game }
    end
  end

  private

  def move_params
    params.require(:move).permit(:column, :value)
  end
end
