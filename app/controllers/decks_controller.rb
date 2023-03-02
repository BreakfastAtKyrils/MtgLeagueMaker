class DecksController < ApplicationController
  before_action :player

  def index
    @decks = @player.decks

    respond_to do |format|
      format.html
      format.json { render json: { decks: @decks } }
    end
  end

  def show
    @deck = @player.decks.find(params[:id])

    respond_to do |format|
      format.html

      format.json do
        render json: { deck: @deck }
      end
    end
  end

  def new
    @deck = @player.decks.build
  end

  def edit
    @deck = @player.decks.find(params[:id])
  end

  def create
    @deck = @player.decks.build(deck_params)

    if @deck.save
      deck_successfully_created
    else
      invalid_record(redirect_path: "/players/#{player.id}/decks", resource: @deck)
    end
  end

  def update
    @deck = @player.decks.find(params[:id])
    @deck.name = deck_params[:name]

    if @deck.save
      deck_successfully_updated
    else
      invalid_record(redirect_path: "/players/#{player.id}/decks", resource: @deck)
    end
  end

  def destroy
    @deck = @player.decks.find(params[:id])

    if @deck.destroy
      deck_successfully_deleted
    else
      invalid_record(redirect_path: "/players/#{player.id}/decks", resource: @deck)
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :player_id)
  end

  def player
    @player = Player.find(params[:player_id])
  end

  def set_deck
    @deck = @player.decks.find(params[:id])
  end

  def deck_successfully_created
    respond_to do |format|
      format.html do
        redirect_to player_path(@player),
          status: :created,
          notice: "New deck successfully added to the database: #{@deck.name}"
      end
      format.json do
        render json: { deck: @deck }, status: :created
      end
    end
  end

  def deck_successfully_deleted
    respond_to do |format|
      format.html do
        redirect_to  "/players/#{player.id}/decks",
          notice: t(:deck_successful_deletion)
      end
      format.json do
        render json: { deck: @deck }, status: :ok
      end
    end
  end

  def deck_successfully_updated
    respond_to do |format|
      format.html do
        redirect_to "/players/#{player.id}/decks",
          notice: t(:deck_successful_updated)
      end
      format.json do
        render json: { deck: @deck }, status: :ok
      end
    end
  end
end
