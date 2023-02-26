require 'rails_helper'

RSpec.describe 'GET /decks' do
  let!(:player) { create(:player, name: 'Pavle') }

  it 'returns http success' do
    get "/players/#{player.id}/decks.json"
    expect(response).to have_http_status(:success)
  end

  context 'when there are decks in the database' do
    let!(:deck) { create(:deck, name: 'Omnath', player: player) }

    it 'returns the list of decks' do
      get "/players/#{player.id}/decks.json"
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:decks]).to include(hash_including(name: deck.name))
    end
  end

  context 'when there are no decks in the database' do
    it 'returns empty array' do
      get "/players/#{player.id}/decks.json"
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:decks]).to eq []
    end
  end
end
