require 'rails_helper'

RSpec.describe 'GET /games' do
  it 'returns http success' do
    get '/games.json'
    expect(response).to have_http_status(:success)
  end

  context 'when adding a game to the database' do
    it 'returns a non-empty array' do
      # I know the following variable is not used, but I want to make sure the db has 1 game record for this test
      game = create(:game, played_at: DateTime.now.strftime('%B %d, %Y'))

      get '/games.json'
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:games]).not_to be_empty
    end
  end

  context 'when there are no games in the database' do
    it 'returns empty array' do
      get '/games.json'
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:games]).to be_empty
    end
  end
end
