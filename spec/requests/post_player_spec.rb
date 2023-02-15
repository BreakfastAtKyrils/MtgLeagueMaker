require 'rails_helper'

RSpec.describe 'POST /players' do
  player_name = 'Karl'

  context 'when provided with a player name' do
    it 'returns the correct status code' do
      post '/players', params: { player: { name: player_name } }
      expect(response).to have_http_status :created
    end

    it 'increases the Player.count by 1' do
      expect { post '/players', params: { player: { name: player_name } } }.to change(Player, :count).by(1)
    end

    it 'persists the player in the database' do
      post '/players', params: { player: { name: player_name } }
      last_player_name = Player.last[:name]

      expect(player_name).to eq last_player_name
    end
  end
end
