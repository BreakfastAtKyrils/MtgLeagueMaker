require 'rails_helper'

RSpec.describe 'GET /decks' do
  it 'returns http success' do
    get '/decks.json'
    expect(response).to have_http_status(:success)
  end

  context 'when there are decks in the database' do
    it 'returns the list of decks' do
      pavle = create(:player, name: 'Pavle')
      omnath = create(:deck, name: 'Omnath', player: pavle)

      get '/decks.json'
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:decks][0]).to include(name: omnath.name)
    end
  end

  context 'when there are no decks in the database' do
    it 'returns empty array' do
      get '/decks.json'
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:decks]).to eq []
    end
  end
end
