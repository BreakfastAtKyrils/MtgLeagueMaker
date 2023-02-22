require 'rails_helper'

RSpec.describe 'players' do
  it_behaves_like 'a delete request' do
    let(:record) { create(:player, name: 'Karl') }
    let(:valid_path) { "/players/#{record.id}.json" }
    let(:invalid_path) { '/players/invalid.json' }
    let(:expected_json_attributes) do
      { player: hash_including(name: 'Karl') }
    end
  end
end
