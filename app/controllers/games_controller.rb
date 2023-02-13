class GamesController < ApplicationController
  def index
    @games = Game.all

    respond_to do |format|
      format.html

      format.json do
        render json: { games: @games }
      end
    end
  end
end
