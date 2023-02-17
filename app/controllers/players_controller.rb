class PlayersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

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
  end

  def edit
    @player = Player.find(params[:id])
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      player_successfully_saved
    else
      invalid_record(redirect_path: new_player_path)
    end
  end

  def update
    @player = Player.find(params[:id])

    if @player.update(player_params)
      player_successfully_updated
    else
      invalid_record(redirect_path: edit_player_path)
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

  def player_successfully_updated
    respond_to do |format|
      format.html do
        redirect_to player_path,
          status: :ok,
          notice: t(:player_successful_updated)
      end
      format.json do
        render json: { player: @player }, status: :ok
      end
    end
  end

  def invalid_record(redirect_path:)
    respond_to do |format|
      format.html do
        redirect_to redirect_path, alert: t(:invalid_name)
      end
      format.json do
        render json: { errors: @player.errors }, status: :unprocessable_entity
      end
    end
  end

  def not_found
    render json: 'Record not found', status: :not_found
  end
end
