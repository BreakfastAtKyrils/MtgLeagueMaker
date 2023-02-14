require 'rails_helper'

RSpec.describe 'POST /players' do
  let(:player) { Player.create(name: 'Karl') }
  let(:deck) { Deck.create(name: 'Krark', player: player) }

  context 'when provided with valid deck id' do
    let(:response_body) do
      JSON.parse(response.body, symbolize_names: true)
    end

    before do
      get "/decks/#{deck.id}.json"
    end

    it 'returns the correct status code' do
      expect(response).to have_http_status :ok
    end

    it 'returns the correct body' do
      expect(response_body[:deck]).to include(name: 'Krark')
    end
  end

  context 'when provided an invalid id' do
    before do
      invalid_id = 'invalid'
      get "/decks/#{invalid_id}.json"
    end

    it 'returns the correct status code' do
      expect(response).to have_http_status :not_found
    end

    it 'returns the correct body' do
      expect(response.body).to eq 'Record not found'
    end
  end
end
