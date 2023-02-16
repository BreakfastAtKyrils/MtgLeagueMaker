require 'rails_helper'

RSpec.describe 'POST /players' do
  player_name = 'Karl'

  context 'when provided with a player name' do
    it 'returns the correct status code' do
      post '/players.json', params: { player: { name: player_name } }
      expect(response).to have_http_status :created
    end

    it 'persists the player in the database' do
      post '/players.json', params: { player: { name: player_name } }
      last_player_name = Player.last[:name]

      expect(player_name).to eq last_player_name
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
      expect(response.body).to eq 'Invalid Record'
    end
  end
end
