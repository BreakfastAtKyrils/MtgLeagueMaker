require 'rails_helper'

RSpec.describe 'GET /players/:id' do
  let(:player) { Player.create(name: 'Karl') }

  context 'when provided with valid player id' do
    let(:response_body) do
      JSON.parse(response.body, symbolize_names: true)
    end

    before do
      get "/players/#{player.id}.json"
    end

    it 'returns the correct status code' do
      expect(response).to have_http_status :ok
    end

    it 'returns the correct body' do
      expect(response_body).to include(name: 'Karl')
    end
  end

  context 'when provided an invalid id' do
    before do
      invalid_id = 'invalid'
      get "/players/#{invalid_id}.json"
    end

    it 'returns the correct status code' do
      expect(response).to have_http_status :not_found
    end

    it 'returns the correct body' do
      expect(response.body).to eq 'Record not found'
    end
  end
end
