class DecksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  before_action :player

  def index
    @decks = @player.decks
    render json: { decks: @decks }
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

  def create
    @deck = @player.decks.build(deck_params)

    if @deck.save
      deck_successfully_created
    else
      invalid_record(redirect_path: root)
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

  # def deck_successfully_deleted
  #   respond_to do |format|
  #     format.html do
  #       redirect_to decks_path,
  #         notice: t(:deck_successful_deletion)
  #     end
  #     format.json do
  #       render json: { deck: @deck }, status: :ok
  #     end
  #   end
  # end

  # def deck_successfully_updated
  #   respond_to do |format|
  #     format.html do
  #       redirect_to deck_path(@deck),
  #         notice: t(:deck_successful_updated)
  #     end
  #     format.json do
  #       render json: { deck: @deck }, status: :ok
  #     end
  #   end
  # end

  def invalid_record(redirect_path:)
    respond_to do |format|
      format.html { redirect_to redirect_path, alert: t(:invalid_name) }
      format.json { render json: { errors: @deck.errors }, status: :unprocessable_entity }
    end
  end

  def not_found
    render json: { errors: ['Record not found'] }, status: :not_found
  end
end
