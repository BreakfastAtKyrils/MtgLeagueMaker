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

  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html

      format.json do
        render json: { game: @game }
      end
    end
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      game_successfully_created
    else
      invalid_record(redirect_path: new_game_path)
    end
  end

  def update
    @game = Game.find(params[:id])
    @game.played_at = game_params[:played_at]
    @game.state = game_params[:state]

    if @game.save
      game_successfully_updated
    else
      invalid_record(redirect_path: edit_game_path)
    end
  end

  def destroy
    @game = Game.find(params[:id])

    if @game.destroy
      game_successfully_deleted
    else
      invalid_record(redirect_path: game_path(@game))
    end
  end

  private

  def game_params
    params.require(:game).permit(:played_at, :state)
  end

  def game_successfully_created
    respond_to do |format|
      format.html do
        redirect_to games_path,
          status: :created,
          notice: "New game successfully added to the database: #{@game.name}"
      end
      format.json do
        render json: { game: @game }, status: :created
      end
    end
  end

  def game_successfully_updated
    respond_to do |format|
      format.html do
        redirect_to game_path(@game),
          notice: t(:game_successful_updated)
      end
      format.json do
        render json: { game: @game }, status: :ok
      end
    end
  end

  def game_successfully_deleted
    respond_to do |format|
      format.html do
        redirect_to games_path,
          notice: t(:game_successful_deletion)
      end
      format.json do
        render json: { game: @game }, status: :ok
      end
    end
  end

  def invalid_record(redirect_path:)
    respond_to do |format|
      format.html { redirect_to redirect_path, alert: t(:invalid_name) }
      format.json { render json: { errors: @game.errors }, status: :unprocessable_entity }
    end
  end
end
