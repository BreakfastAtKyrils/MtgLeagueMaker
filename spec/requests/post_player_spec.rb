require 'rails_helper'

RSpec.describe 'POST /players' do
  player_name = 'Karl'

  context 'when provided with a player name' do
    before do
      post '/players.json', params: { player: { name: player_name } }
    end

    it 'returns the correct status code' do
      expect(response).to have_http_status :created
    end

    it 'returns the created player' do
      player = JSON.parse(response.body, symbolize_names: true)[:player]

      expect(player).to include(name: player_name)
    end
  end

  context 'when provided with no player name' do
    before do
      post '/players.json', params: { player: { name: nil } }
    end

    it 'returns the correct status code' do
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'returns a json error message' do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:errors]).to eq({ name: ["can't be blank"] })
    end
  end
end
