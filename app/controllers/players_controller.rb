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
    # would like 5 min talk about line 15 to fully understand it, then will delete both comments
    # @player = Player.find(params[:id])
    @decks = @player.decks

    respond_to do |format|
      format.html

      format.json do
        render json: [@player, { decks: @decks }], status: :ok
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
