require 'rails_helper'

RSpec.describe 'decks' do
  it_behaves_like 'a get request' do
    let(:player) { create(:player, name: 'Pavle') }
    let(:record) { create(:deck, name: 'Ragavan', player: player) }
    let(:path) { "/players/#{player.id}/decks/#{record.id}.json" }
    let(:expected_json_attributes) do
      { deck: hash_including(name: 'Ragavan') }
    end
  end

  it_behaves_like 'a post request' do
    let(:player) { create(:player, name: 'Jules') }
    let(:path) { "/players/#{player.id}/decks.json" }
    let(:record) { create(:deck, name: 'Ragavan', player: player) }
    let(:valid_request_params) do
      { deck: { name: 'Ragavan', player_id: record.player_id } }
    end
    let(:invalid_request_params) do
      { deck: { name: nil } }
    end
    let(:expected_json_attributes) do
      { deck: hash_including(name: 'Ragavan') }
    end
  end

  it_behaves_like 'a delete request' do
    let(:player) { create(:player, name: 'Jules') }
    let(:record) { create(:deck, name: 'Tivit', player: player) }
    let(:path) { "/players/#{player.id}/decks/#{record.id}.json" }
    let(:expected_json_attributes) do
      { deck: hash_including(name: 'Tivit') }
    end
  end

  it_behaves_like 'a put request' do
    let(:player) { create(:player, name: 'Jules') }
    let(:record) { create(:deck, name: 'Purphoros', player: player) }
    let(:path) { "/players/#{player.id}/decks/#{record.id}.json" }
    let(:valid_request_params) do
      { deck: { name: 'Kiki-Jiki', player_id: player.id } }
    end
    let(:invalid_request_params) do
      { deck: { name: nil } }
    end
    let(:expected_json_attributes) do
      { deck: hash_including(name: 'Kiki-Jiki', player_id: player.id) }
    end
  end
end
