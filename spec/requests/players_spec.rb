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
end
