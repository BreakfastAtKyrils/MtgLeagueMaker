require 'rails_helper'

RSpec.describe 'GET /players' do
  it 'returns http success' do
    get '/players.json'
    expect(response).to have_http_status(:success)
  end

  context 'when there are players in the database' do
    let!(:player) { create(:player, name: 'francis') }
    let(:body) do
      get '/players.json'
      JSON.parse(response.body, symbolize_names: true)
    end

    it 'returns the list of players' do
      expect(body[:players]).to include(hash_including(name: player.name))
    end

    it 'returns the player names correctly' do
      expect(body[:players][0][:name]).to eq 'francis'
    end
  end

  context 'when there are no players in the database' do
    it 'returns empty array' do
      get '/players.json'
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:players]).to eq []
    end
  end
end
