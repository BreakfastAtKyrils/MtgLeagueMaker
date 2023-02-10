class PlayersController < ApplicationController
  def index
    @players = Player.all

    respond_to do |format|
      format.html

      format.json do
        render json: { players: @players }
      end
    end
  end

  def show
    @player = Player.includes(:decks).find(params[:id])

    respond_to do |format|
      format.html

      format.json do
        render json: { player: @player }
      end
    end
  rescue ActiveRecord::RecordNotFound
    render json: 'Record not found', status: :not_found
  end

  def edit; end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
