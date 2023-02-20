require 'rails_helper'

RSpec.describe 'DELETE /players.json' do
  let(:player) { Player.create(name: 'Karl') }

  context 'when given a valid player id' do
    before do
      valid_id = player.id
      delete "/players/#{valid_id}.json"
    end

    it 'returns the correct http response' do
      expect(response).to have_http_status :ok
    end

    it 'deletes the player from the database' do
      expect { Player.find(player.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when given an invalid player id' do
    before do
      invalid_id = 'invalid_id'
      delete "/players/#{invalid_id}.json"
    end

    it 'returns the correct http response' do
      expect(response).to have_http_status :not_found
    end

    it 'returns a json error message' do
      expect(response.body).to eq 'Record not found'
    end
  end
end
