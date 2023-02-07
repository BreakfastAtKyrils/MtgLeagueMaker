class PlayersController < ApplicationController
  def index
    render json: serialized_players, status: :ok
  end

  def show
    player = Player.find(params[:id])
    render json: player, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: 'Record not found', status: :not_found
  end

  def edit; end

  private

  def serialized_players
    {
      players: players.map do |player|
        { name: player.name }
      end
    }
  end

  def players
    @players ||= Player.all
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
