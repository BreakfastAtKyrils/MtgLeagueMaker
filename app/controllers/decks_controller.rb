class DecksController < ApplicationController
  def index
    @decks = Deck.all
    render json: { decks: @decks }
  end

  def show
    @deck = Deck.find(params[:id])
    render json: { deck: @deck }
  rescue ActiveRecord::RecordNotFound
    render json: 'Record not found', status: :not_found
  end
end
