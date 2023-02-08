require 'rails_helper'

RSpec.describe 'GET /players' do
  it 'returns http success' do
    get '/players.json'
    expect(response).to have_http_status(:success)
  end

  context 'when there are players in the database' do
    it 'returns the list of players' do
      francis = create(:player, name: 'francis')

      get '/players.json'
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:players][0]).to include(name: francis.name)
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
