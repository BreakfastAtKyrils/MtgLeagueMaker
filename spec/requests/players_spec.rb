require 'rails_helper'

RSpec.describe 'players' do
  it_behaves_like 'a delete request' do
    let(:record) { create(:player, name: 'Karl') }
    let(:path) { "/players/#{record.id}.json" }
    let(:expected_json_attributes) do
      { player: hash_including(name: 'Karl') }
    end
  end

  it_behaves_like 'a get request' do
    let(:record) { create(:player, name: 'Karl') }
    let(:path) { "/players/#{record.id}.json" }
    let(:expected_json_attributes) do
      { player: hash_including(name: 'Karl') }
    end
  end

  it_behaves_like 'a post request' do
    let(:path) { '/players.json' }
    let(:valid_request_params) do
      { player: { name: 'Pavle' } }
    end
    let(:invalid_request_params) do
      { player: { name: nil } }
    end
    let(:expected_json_attributes) do
      { player: hash_including(name: 'Pavle') }
    end
  end

  it_behaves_like 'a put request' do
    let(:record) { create(:player, name: 'Karl') }
    let(:path) { "/players/#{record.id}.json" }
    let(:valid_request_params) do
      { player: { name: 'Pavle' } }
    end
    let(:invalid_request_params) do
      { player: { name: nil } }
    end
    let(:expected_json_attributes) do
      { player: hash_including(name: 'Pavle') }
    end
  end
end
