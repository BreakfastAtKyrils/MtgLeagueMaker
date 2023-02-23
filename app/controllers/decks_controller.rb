class DecksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  def index
    @decks = Deck.all
    render json: { decks: @decks }
  end

  def show
    @deck = Deck.find(params[:id])
    render json: { deck: @deck }
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Record not found'] }, status: :not_found
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(deck_params)

    if @deck.save
      deck_successfully_created
    else
      invalid_record(redirect_path: new_deck_path)
    end
  end

  def update
    @deck = Deck.find(params[:id])
    @deck.name = deck_params[:name]
    @deck.player_id = deck_params[:player_id]

    if @deck.save
      deck_successfully_updated
    else
      invalid_record(redirect_path: edit_deck_path)
    end
  end

  def destroy
    @deck = Deck.find(params[:id])

    if @deck.destroy
      deck_successfully_deleted
    else
      invalid_record(redirect_path: deck_path(@deck))
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :player_id)
  end

  def deck_successfully_created
    respond_to do |format|
      format.html do
        redirect_to players_path,
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
        redirect_to decks_path,
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
        redirect_to deck_path(@deck),
          notice: t(:deck_successful_updated)
      end
      format.json do
        render json: { deck: @deck }, status: :ok
      end
    end
  end

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
