require 'rails_helper'

RSpec.describe 'games' do
  it_behaves_like 'a get request' do
    let(:record) { create(:game, state: :completed) }
    let(:path) { "/games/#{record.id}.json" }
    let(:expected_json_attributes) do
      { game: hash_including(state: 'completed') }
    end
  end

  it_behaves_like 'a post request' do
    let(:path) { '/games.json' }
    let(:record) { create(:game, state: :pending) }
    let(:valid_request_params) do
      { game: { played_at: Time.zone.now, state: 'pending' } }
    end
    let(:invalid_request_params) do
      { game: { played_at: nil } }
    end
    let(:expected_json_attributes) do
      { game: hash_including(state: 'pending') }
    end
  end

  it_behaves_like 'a delete request' do
    let(:record) { create(:game, state: :pending) }
    let(:path) { "/games/#{record.id}.json" }
    let(:expected_json_attributes) do
      { game: hash_including(state: 'pending') }
    end
  end

  it_behaves_like 'a put request' do
    let(:record) { create(:game, state: :pending) }
    let(:path) { "/games/#{record.id}.json" }
    let(:valid_request_params) do
      { game: { played_at: Time.zone.now, state: :completed } }
    end
    let(:invalid_request_params) do
      { game: { played_at: nil } }
    end
    let(:expected_json_attributes) do
      { game: hash_including(state: 'completed') }
    end
  end
end
