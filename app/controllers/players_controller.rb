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

  def new
    @player = Player.new
    render :new
  end

  def create
    @player = Player.new(params.require(:player).permit(:name))

    if @player.save
      redirect_to players_path,
        status: :created,
        notice: "New player successfully added to the database: #{@player.name}"
    else
      redirect_to new_player_path, alert: 'Please enter a valid name'
    end
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
