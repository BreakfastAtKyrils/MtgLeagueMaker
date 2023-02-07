class PlayerController < ApplicationController
  def index
    render json: serialized_players
  end

  def show; end

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
