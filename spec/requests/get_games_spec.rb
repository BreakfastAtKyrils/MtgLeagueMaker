require 'rails_helper'

RSpec.describe 'GET /games' do
  it 'returns http success' do
    get '/games.json'
    expect(response).to have_http_status(:success)
  end

  context 'when some games are persisted' do
    let!(:game) { create(:game, played_at: DateTime.now.strftime('%B %d, %Y')) }

    before do
      get '/games.json'
    end

    it 'returns the games ids' do
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:games]).to match([
        hash_including(id: game.id)
      ])
    end

    it 'returns the games played_at attribute' do
      body = JSON.parse(response.body, symbolize_names: true)
      formatted_played_at = ActiveSupport::TimeZone['UTC'].parse((body[:games][0][:played_at]))

      expect(game.played_at).to eq(formatted_played_at)
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
