class DecksController < ApplicationController
  def index
    @decks = Deck.all

    respond_to do |format|
      format.html

      format.json do
        render json: { decks: @decks }
      end
    end
  end

  def show
    deck = Deck.find(params[:id])
    render json: deck, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: 'Record not found', status: :not_found
  end

  def edit; end
end
