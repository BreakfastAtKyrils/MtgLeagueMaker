class PlayersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid

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
  end

  def new
    @player = Player.new
    render
  end

  def create
    @player = Player.new(params.require(:player).permit(:name))

    if @player.save
      player_successfully_saved
    else
      player_unsuccessfully_saved
    end
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end

  def player_successfully_saved
    respond_to do |format|
      format.html do
        redirect_to players_path,
          status: :created,
          notice: "New player successfully added to the database: #{@player.name}"
      end
      format.json do
        render json: { player: @player }, status: :created
      end
    end
  end

  def player_unsuccessfully_saved
    respond_to do |format|
      format.html do
        redirect_to new_player_path, alert: t(:invalid_name)
      end
      format.json do
        render json: 'Invalid Record', status: :unprocessable_entity
      end
    end
  end

  def not_found
    render json: 'Record not found', status: :not_found
  end

  def invalid
    render json: { error: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
