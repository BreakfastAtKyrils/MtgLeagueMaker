require 'rails_helper'

RSpec.describe 'PUT /players.json' do
  valid_new_player_name = 'Bianca'
  let(:player) { Player.create(name: 'Karl') }

  context 'when given a valid player id' do
    context 'when given a valid new player name' do
      before do
        valid_id = player.id
        put "/players/#{valid_id}.json", params: { player: { name: valid_new_player_name } }
      end

      it 'returns the correct http response' do
        expect(response).to have_http_status :ok
      end

      it 'changes the player name' do
        expect(player.reload.name).to eq valid_new_player_name
      end
    end
  end

  context 'when given an invalid player id' do
    before do
      invalid_id = 'invalid_id'
      put "/players/#{invalid_id}.json", params: { player: { name: valid_new_player_name } }
    end

    it 'returns the correct http response' do
      expect(response).to have_http_status :not_found
    end

    it 'returns a json error message' do
      expect(response.body).to eq 'Record not found'
    end
  end
end
